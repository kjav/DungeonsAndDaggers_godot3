extends Node
# GameAnalytics <https://gameanalytics.com/> native GDScript REST API implementation
# Cross-platform. Should work in every platform supported by Godot
# Adapted from REST_v2_example.py by Cristiano Reis Monteiro <cristianomonteiro@gmail.com> Abr/2018

""" Procedure -->
1. make an init call
	- check if game is disabled
	- calculate client timestamp offset from server time
2. start a session
3. add a user event (session start) to queue
4. add a business event + some design events to queue
5. submit events in queue
6. add some design events to queue
7. add session_end event to queue
8. submit events in queue
"""
# From https://github.com/xsellier/godot-uuid
const UUID = preload("res://Singletons/uuid.gd")
# device information
var DEBUG = false
var returned
var response_data
var response_code
var uuid = UUID.v4()

var platform = OS.get_name()
var os_version = OS.get_name()
var sdk_version = 'rest api v2'
var device = OS.get_model_name()
var manufacturer = OS.get_name()
var user_id = OS.get_unique_id()
var session_num = false
var cache_file

# game information
var build_version = 'alpha 0.0.1'
var engine_version = Engine.get_version_info()["string"]

# sandbox game keys
var game_key = "87a054a967f72b658c3fc5baffb4fbb0"
var secret_key = "31703bfad98786776412ff2ec4fa39740c268605"

# sandbox API urls
var base_url = "http://api.gameanalytics.com"
var url_init = "/v2/" + game_key + "/init"
var url_events = "/v2/" + game_key + "/events"

# settings
var use_gzip = false
var verbose_log = true
var thread
var mutex
var semaphore
var exit_thread = false
var start_time
var duration

# global state to track changes when code is running
var state_config = {
	# the amount of seconds the client time is offset by server_time
	# will be set when init call receives server_time
	'client_ts_offset': 0,
	# will be updated when a new session is started
	'session_id': uuid,
	# set if SDK is disabled or not - default enabled
	'enabled': true,
	# event queue - contains a list of event dictionaries to be JSON encoded
	'event_queue': [],
	# The index of the last event to be written, inclusive
	'written_events': -1,
	# The index of the last sent event, not inclusive
	'sent_events': 0
}
var requests = HTTPClient.new()

func get_session_num():
	var file = File.new()
	# Determine if session number file exists
	if file.file_exists("user://SESSION_NUMBER"):
		# If so, increment session number
		file.open("user://SESSION_NUMBER", File.READ_WRITE)
		session_num = file.get_32() + 1
	else:
		# If not, set session number to one
		session_num = 1
		file.open("user://SESSION_NUMBER", File.WRITE)
	# Finally, write session number to file
	file.seek(0)
	file.store_32(session_num)
	file.close()

func get_transaction_number():
	var file = File.new()
	var transaction_number
	# Determine if session number file exists
	if file.file_exists("user://TRANSACTION_NUMBER"):
		# If so, increment session number
		file.open("user://TRANSACTION_NUMBER", File.READ_WRITE)
		transaction_number = file.get_32() + 1
	else:
		# If not, set session number to one
		transaction_number = 1
		file.open("user://TRANSACTION_NUMBER", File.WRITE)
	# Finally, write session number to file
	file.seek(0)
	file.store_32(transaction_number)
	file.close()

# Must call send_previous_events first to initialise file
func write_event_to_file(event_dict):
	cache_file.open('user://' + str(session_num) + '.analytics.backup', File.WRITE)
	var json_string = JSON.print(event_dict)
	cache_file.store_line(json_string)
	cache_file.close()

func list_old_backup_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.ends_with(".analytics.backup"):
				if not int(file.split(".")[0]) == session_num:
					files.append(file)

	dir.list_dir_end()

	return files

func send_previous_events():
	var dir = Directory.new()
	var old_backup_files = list_old_backup_files("user://")
	for filepath in old_backup_files:
		var file = File.new()
		file.open("user://" + filepath, File.READ)
		var unfinished_events = []
		var contains_end_event = false
		while not file.eof_reached():
			var event_str = file.get_line()
			if event_str:
				
				var event_dict = JSON.parse(event_str).result
				contains_end_event = contains_end_event or event_dict['category'] == 'session_end'
				unfinished_events.append(event_dict)
		if not unfinished_events.empty():
			if not contains_end_event:
				var earliest_time = unfinished_events[0]['client_ts']
				var latest_time = earliest_time
				for e in unfinished_events:
					var client_ts = e['client_ts']
					earliest_time = min(earliest_time, client_ts)
					latest_time = max(latest_time, client_ts)
				# Annotate the new event with old event values. We don't copy as we
				# don't want all of the event properties for other event types.
				var end_event = {
					'v': unfinished_events[0]['v'],
					'user_id': unfinished_events[0]['user_id'],
					'sdk_version': unfinished_events[0]['sdk_version'],
					'os_version': unfinished_events[0]['os_version'],
					'manufacturer': unfinished_events[0]['manufacturer'],
					'limit_ad_tracking': unfinished_events[0]['limit_ad_tracking'],
					'device': unfinished_events[0]['device'],
					'platform': unfinished_events[0]['platform'],
					'session_id': unfinished_events[0]['session_id'],
					'session_num': unfinished_events[0]['session_num'],
					'category': 'session_end',
					'client_ts': latest_time,
					'length': latest_time - earliest_time
				}
				unfinished_events.append(end_event)
				submit_events_json(to_json(unfinished_events))
		file.close()
		dir.remove("user://" + filepath)
	

func _ready():
	start_time = OS.get_unix_time()
	get_session_num()
	# Open the new cache file
	cache_file = File.new()
	# There is no "windows" platform on GA
	platform = platform.to_lower()
	manufacturer = manufacturer.to_lower()
	os_version = platform.to_lower()
	if Engine.has_singleton("MySingleton"):
		os_version += " " + Ad.getDeviceVersion()
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	send_previous_events()

func start_analytics():
	thread = Thread.new()
	thread.start(self, "_thread_function", 1)
	#add_to_event_queue(get_test_design_event('test', 1337))

func _thread_function(x):
	generate_new_session_id()
	request_init()
	add_to_event_queue(get_user_event())
	while true:
		semaphore.wait()
		mutex.lock()
		var should_exit = exit_thread
		mutex.unlock()
		
		# Wait for more events to accumulate, in case many events are queued at
		# once; this helps reduce the number of requests submitted. We don't
		# do this when exiting as it will appear to hang.
		if not should_exit:
			OS.delay_msec(200)
		
		mutex.lock()
		submit_events()
		mutex.unlock()
		
		if should_exit:
			break
	
# adding an event to the queue for later submit
func add_to_event_queue(event_dict):
#    if not isinstance(event_dict, dict):
#        return
	#annotate_event_with_default_values(event_dict)
	#annotate_event_with_default_values()
	state_config['event_queue'].append(event_dict)
	write_event_to_file(event_dict)
	mutex.lock()
	state_config['written_events'] += 1
	mutex.unlock()
	semaphore.post()

# requesting init URL and returning result
func request_init():
	var init_payload = {
		'platform': platform,
		'os_version': os_version,
		'sdk_version': sdk_version,
		'user_id': user_id
	}
	
	# Refreshing url_init since game key might have been changed externally
	url_init = "/v2/" + game_key + "/init"
	#var queryString = requests.query_string_from_dict(init_payload)
	#var init_payload_json = json.dumps(init_payload)
	var init_payload_json = to_json(init_payload)

# For GZip compression
#    var f = File.new()
#
#    f.open_compressed("user://temp2", File.WRITE, File.COMPRESSION_GZIP)
#    f.store_string(init_payload_json)
#    f.close()
#
#    f.open("user://temp2", File.READ)
#    init_payload_json = f.get_as_text()
#    f.close()

	var headers = [
		"Authorization: " + Marshalls.raw_to_base64(hmac_sha256(init_payload_json, secret_key)),
		"Content-Type: application/json"]
	#var headers = ["\"Authorization: " +  Marshalls.raw_to_base64(hmac_sha256(init_payload_json, secret_key)) + "\"", "\"Content-Type: application/json\""]
	print_verbose(Marshalls.raw_to_base64(hmac_sha256(init_payload_json, secret_key)))
	#response_dict = None
	#status_code = None
	var response_dict
	var status_code
	
	
	print_verbose(base_url)
	print_verbose(url_init)
	print_verbose(init_payload_json)
	print_verbose(Marshalls.raw_to_base64(hmac_sha256(init_payload_json, secret_key)))
		
	#try:
	var err = requests.connect_to_host(base_url,80)

		# Wait until resolved and connected
	while requests.get_status() == HTTPClient.STATUS_CONNECTING or requests.get_status() == HTTPClient.STATUS_RESOLVING:
		requests.poll()
		print_verbose("Connecting..")
		OS.delay_msec(50)

	# Error catch: Could not connect
	#assert(requests.get_status() == HTTPClient.STATUS_CONNECTED)
	#var h = [to_json(headers)]
	var init_response = requests.request(HTTPClient.METHOD_POST, url_init, headers, init_payload_json)
#    except:
#        post_to_log("Init request failed!")
#        sys.exit()
	while requests.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling until the request is going on
		requests.poll()
		print_verbose("Requesting..")
		OS.delay_msec(50)
	
	if requests.has_response():
		# If there is a response..
		headers = requests.get_response_headers_as_dictionary() # Get response headers
		print_verbose("code: ", requests.get_response_code()) # Show response code
		print_verbose("**headers:\\n", headers) # Show headers

		# Getting the HTTP Body

		if requests.is_response_chunked():
			# Does it use chunks?
			print_verbose("Response is Chunked!")
		else:
			# Or just plain Content-Length
			var bl = requests.get_response_body_length()
			print_verbose("Response Length: ",bl)

		# This method works for both anyway

		var rb = PoolByteArray() # Array that will hold the data

		while requests.get_status() == HTTPClient.STATUS_BODY:
			# While there is body left to be read
			requests.poll()
			var chunk = requests.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
				# Got nothing, wait for buffers to fill a bit
				OS.delay_usec(200)
			else:
				rb = rb + chunk # Append to read buffer

		# Done!

		print_verbose("bytes got: ", rb.size())
		print_verbose("Response code: ", requests.get_response_code())
		var text = rb.get_string_from_ascii()
		print_verbose("Text: ", text)
		
	#status_code = init_response.status_code
	status_code = requests.get_response_code()
	print_verbose("Init response: ", init_response)
	#try:
	response_dict = to_json(init_response)
#    except:
#        response_dict = None

#    if not isinstance(status_code, (long, int)):
#        post_to_log("---- Submit Init ERROR ----")
#        post_to_log("URL: " + str(url_init))
#        post_to_log("Payload JSON: " + str(init_payload_json))
#        post_to_log("Headers: " + str(headers))
#    var a
#    if status_code is null:
#        a = ""
#    else a = "Returned: " + str(status_code) + " response code."
	
	var response_string = (status_code)

	if status_code == 401:
		print_verbose("Submit events failed due to UNAUTHORIZED.")
		print_verbose("Please verify your Authorization code is working correctly and that your are using valid game keys.")
		#sys.exit()

	if status_code != 200:
		print_verbose("Init request did not return 200!")
		print_verbose(response_string)
#        if isinstance(response_dict, dict):
#            post_to_log(response_dict)
#        elif isinstance(init_response.text, basestring):
#            post_to_log("Response contents: " + init_response.text)
		#sys.exit()

	# init request ok --> get values
#    if 'server_ts' not in response_dict or not isinstance(response_dict['server_ts'], (int, long)):
#        post_to_log("Init request failed! Did not return proper server_ts..")
#        sys.exit()

#    if 'enabled' in response_dict and !response_dict['enabled']:
#        state_config['enabled'] = false

	#return Vector2(response_dict, status_code)
	return status_code


# submitting all events that are in the queue to the events URL
func submit_events():
	print_verbose("Submitting events")
	
	mutex.lock()
	var sent_events = state_config['sent_events']
	var written_events = state_config['written_events']
	mutex.unlock()
	submit_events_json(to_json(state_config['event_queue'].slice(sent_events, written_events)))
	mutex.lock()
	# sent_events is not inclusive, so set it to written_events + 1
	state_config['sent_events'] = written_events + 1
	mutex.unlock()

func submit_events_json(event_list_json):
	# Refreshing url_events since game key might have been changed externally
	url_events = "/v2/" + game_key + "/events"
	var original_message = event_list_json
#    except:
#        post_to_log("Event queue failed JSON encoding!")
#        event_list_json = None
#        return

	# clear event queue

#    if event_list_json is null:
#        return

	var message_to_hmac = event_list_json
	# if gzip enabled
	if use_gzip:
		event_list_json = get_gzip_string(event_list_json)
		message_to_hmac = Marshalls.raw_to_base64(event_list_json)
		print_verbose("Message to hmac, in base 64: ", message_to_hmac)

	# create headers with authentication hash
	var headers = [
		"Authorization: " +  Marshalls.raw_to_base64(hmac_sha256(message_to_hmac, secret_key)),
		"Content-Type: application/json"
	]
	print_verbose("Headers: ", headers)

	# if gzip enabled add the encoding header
	if use_gzip:
		headers.append('Content-Encoding: gzip')

	var err = requests.connect_to_host(base_url,80)

		# Wait until resolved and connected
	while requests.get_status() == HTTPClient.STATUS_CONNECTING or requests.get_status() == HTTPClient.STATUS_RESOLVING:
		requests.poll()
		print_verbose("Connecting..")
		OS.delay_msec(50)


	#try:
	var events_response = requests.request(HTTPClient.METHOD_POST, url_events, headers, message_to_hmac)
#    except Exception as e:
#        post_to_log("Submit events request failed!")
#        post_to_log(e.reason)
#        return (None, None)
	while requests.get_status() == HTTPClient.STATUS_REQUESTING:
		# Keep polling until the request is going on
		requests.poll()
		print_verbose("Requesting..")
		OS.delay_msec(50)
	
	if requests.has_response():
		# If there is a response..
		headers = requests.get_response_headers_as_dictionary() # Get response headers
		print_verbose("code: ", requests.get_response_code()) # Show response code
		print_verbose("**headers:\\n", headers) # Show headers

		# Getting the HTTP Body

		if requests.is_response_chunked():
			# Does it use chunks?
			print_verbose("Response is Chunked!")
		else:
			# Or just plain Content-Length
			var bl = requests.get_response_body_length()
			print_verbose("Response Length: ",bl)

		# This method works for both anyway

		var rb = PoolByteArray() # Array that will hold the data

		while requests.get_status() == HTTPClient.STATUS_BODY:
			# While there is body left to be read
			requests.poll()
			var chunk = requests.read_response_body_chunk() # Get a chunk
			if chunk.size() == 0:
				# Got nothing, wait for buffers to fill a bit
				OS.delay_usec(200)
			else:
				rb = rb + chunk # Append to read buffer

		# Done!

		print_verbose("bytes got: ", rb.size())
		print_verbose("Response code: ", requests.get_response_code())
		var text = rb.get_string_from_ascii()
		print_verbose("Text: ", text)

	#var status_code = events_response.status_code
	var status_code = requests.get_response_code()
	#try:
	#var response_dict = events_response.json()
#    except:
#        response_dict = None

	#print_verbose("Submit events response: " + str(response_dict))

	# check response code
	#status_code_string = ("" if status_code is None else "Returned: " + str(status_code) + " response code.")
	var status_code_string = str(status_code)
	if status_code == 400:
		print_verbose(status_code_string)
		print_verbose("Submit events failed due to BAD_REQUEST.")

#        if isinstance(response_dict, (dict, list)):
#            post_to_log("Payload found in response. Contents can explain what fields are causing a problem.")
#            post_to_log(events_response.text)
#            sys.exit()
#    elif status_code == 401:
#        post_to_log(status_code_string)
#        post_to_log("Submit events failed due to UNAUTHORIZED.")
#        post_to_log("Please verify your Authorization code is working correctly and that your are using valid game keys.")
#        sys.exit()
	elif status_code != 200:
		print_verbose(status_code_string)
		print_verbose("Submit events request did not succeed! Perhaps offline.. ")
#        sys.exit()

#    if not isinstance(response_dict, dict):
#        post_to_log("Submit events request returned 200, but reading and JSON decoding response failed..")
#        post_to_log(events_response.text)
#        sys.exit()

	if status_code == 200:
		print_verbose("Events submitted !")
	else:
		print_verbose("Event submission FAILED!")

	return status_code


# ------------------ HELPER METHODS ---------------------- #


func generate_new_session_id():
	state_config['session_id'] = uuid
	print_verbose("Session Id: " + state_config['session_id'])


func update_client_ts_offset(server_ts):
	# calculate client_ts using offset from server time
	#datetime.utcnow()
	var now_ts = OS.get_unix_time_from_datetime(OS.get_datetime())
#    var client_ts = calendar.timegm(now_ts.timetuple())
	var client_ts = now_ts
	var offset = client_ts - server_ts
# --> Verificar
	#offset = 0

	# if too small difference then ignore
	if offset < 10:
		state_config['client_ts_offset'] = 0
	else:
		state_config['client_ts_offset'] = offset
	print_verbose('Client TS offset calculated to: ' + str(offset))


#func hmac_hash_with_secret(message, key):
#	#requests.
#    return utf8_to_base64(hmac.new(key, message, hashlib.sha256))

# https://gameanalytics.com/docs/item/rest-api-doc#business
func queue_business_event(
	amount,
	currency,
	event_id,
	cart_type,
	receipt_info={'receipt':'test', 'store': ''}
):
	var event_dict = {
		'category': 'business',
		'amount': amount,
		'currency': currency,
		'event_id': event_id,
		'cart_type': cart_type,
		'transaction_num': get_transaction_number()
	}
	merge_dir(event_dict, annotate_event_with_default_values())
	add_to_event_queue(event_dict)


func get_user_event():
	var event_dict = {
		'category': 'user'
	}
	merge_dir(event_dict, annotate_event_with_default_values())
	return event_dict


func get_session_end_event(length_in_seconds):
	var event_dict = {
		'category': 'session_end',
		'length': length_in_seconds
	}
	merge_dir(event_dict, annotate_event_with_default_values())
	return event_dict

func queue_design_event(event_id, value=0):
	var event_dict = {
		'category': 'design',
		'event_id': event_id,
		'value': value
	}
	merge_dir(event_dict, annotate_event_with_default_values())
	add_to_event_queue(event_dict)

func queue_progress_event(event_id, score=0):
	var event_dict = {
		'category': 'progression',
		'event_id': event_id,
		'score': score,
		'attempt_num': 0
	}
	merge_dir(event_dict, annotate_event_with_default_values())
	add_to_event_queue(event_dict)

static func merge_dir(target, patch):
	for key in patch:
		target[key] = patch[key]

static func merge_dir2(target, patch):
	for key in patch:
		if target.has(key):
			var tv = target[key]
			if typeof(tv) == TYPE_DICTIONARY:
				merge_dir(tv, patch[key])
			else:
				target[key] = patch[key]
		else:
			target[key] = patch[key]
			
func get_gzip_string(string_for_gzip):
	var pba = PoolByteArray(string_for_gzip.to_ascii())
	var pba_gzip = pba.compress(File.COMPRESSION_GZIP)
	return pba_gzip


# add default annotations (will alter the dict by reference)
#func annotate_event_with_default_values(event_dict):
func annotate_event_with_default_values():
	var now_ts = OS.get_datetime()
	# datetime.utcnow()
	# calculate client_ts using offset from server time
	#var client_ts = calendar.timegm(now_ts.timetuple()) - state_config['client_ts_offset']
	var client_ts = OS.get_unix_time_from_datetime(OS.get_datetime())

	# TEST IDFA / IDFV
	#var idfa = 'AEBE52E7-03EE-455A-B3C4-E57283966239'
	var idfa = OS.get_unique_id()
	var idfv = 'AEBE52E7-03EE-455A-B3C4-E57283966239'
	var limit_ad_tracking = not Ad.personalised_checked

	var default_annotations = {
		'v': 2,                                     # (required: Yes)
		'user_id': idfa,                            # (required: Yes)
		#'ios_idfa': idfa,                           # (required: No - required on iOS)
		#'ios_idfv': idfv,                           # (required: No - send if found)
		# 'google_aid'                              # (required: No - required on Android)
		# 'android_id',                             # (required: No - send if set)
		# 'googleplus_id',                          # (required: No - send if set)
		# 'facebook_id',                            # (required: No - send if set)
		# 'logon_gamecenter',                       # (required: No - send if true)
		# 'logon_googleplay                         # (required: No - send if true)
		#'gender': 'male',                           # (required: No - send if set)
		# 'birth_year                               # (required: No - send if set)
		# 'progression                              # (required: No - send if a progression attempt is in progress)
		#'custom_01': 'ninja',                       # (required: No - send if set)
		# 'custom_02                                # (required: No - send if set)
		# 'custom_03                                # (required: No - send if set)
		'client_ts': client_ts,                     # (required: Yes)
		'sdk_version': sdk_version,                 # (required: Yes)
		'os_version': os_version,                   # (required: Yes)
		'manufacturer': manufacturer,                    # (required: Yes)
		'device': device,                      # (required: Yes - if not possible set "unknown")
		'platform': platform,                       # (required: Yes)
		'session_id': state_config['session_id'],   # (required: Yes)
		#'build': build_version,                     # (required: No - send if set)
		'session_num': session_num,                           # (required: Yes)
		#'connection_type': 'wifi',                  # (required: No - send if available)
		# 'jailbroken                               # (required: No - send if true)
		#'engine_version': engine_version            # (required: No - send if set by an engine)
	}
	if limit_ad_tracking:
		default_annotations['limit_ad_tracking'] = true
	#event_dict.update(default_annotations)
	#state_config['event_queue'].append(default_annotations)
	return default_annotations

func print_verbose(message, message2=""):
	if verbose_log:
		post_to_log(message, message2)

func post_to_log(message, message2=""):
	print(message, message2)
# -- RUN -- #
#run()
func hmac_sha256(message, key):
	var x = 0
	var k
	
	if key.length() <= 64:
		k = key.to_utf8()

	# Hash key if length > 64
	if key.length() > 64:
		k =  key.sha256_buffer()

	# Right zero padding if key length < 64
	while k.size() < 64:
		k.append(convert_hex_to_dec("00"))

	var i = "".to_utf8()
	var o = "".to_utf8()
	var m
	m = message.to_utf8()
	var s = File.new()
			
	while x < 64:
		o.append(k[x] ^ 0x5c)
		i.append(k[x] ^ 0x36)
		x += 1
		
	var inner = i + m
	
	s.open("user://temp", File.WRITE)
	s.store_buffer(inner)
	s.close()
	var z = s.get_sha256("user://temp")
	
	var outer = "".to_utf8()
	
	x = 0
	while x < 64:
		outer.append(convert_hex_to_dec(z.substr(x, 2)))
		x += 2
	
	outer = o + outer
	
	s.open("user://temp", File.WRITE)
	s.store_buffer(outer)
	s.close()
	
	z = s.get_sha256("user://temp")
	
	outer = "".to_utf8()
	
	x = 0
	while x < 64:
		outer.append(convert_hex_to_dec(z.substr(x, 2)))
		x += 2
	
	var mm = outer
	return outer

var c = "0123456789ABCDEF"
func convert_hex_to_dec(h):
	
	h = h.to_upper()
	
	var r = h.right(1)
	var l = h.left(1)
	
	var b0 = c.find(r)
	var b1 = c.find(l) * 16
	
	var x = b1 + b0
	return x

func _exit_tree():
	duration = OS.get_unix_time() - start_time
	add_to_event_queue(get_session_end_event(duration))
	# Set exit condition to true.
	mutex.lock()
	exit_thread = true # Protect with Mutex.
	mutex.unlock()

	# Unblock by posting.
	semaphore.post()

	# Wait until it exits.
	if thread:
		thread.wait_to_finish()
	if cache_file:
		cache_file.close()
	var dir = Directory.new()
	var path = "user://" + str(session_num) + ".analytics.backup"
	if dir.file_exists(path):
		dir.remove(path)
	print_verbose("Exited cleanly")
