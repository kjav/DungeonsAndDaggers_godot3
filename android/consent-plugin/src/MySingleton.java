package org.godotengine.godot;

import java.net.URL;
import java.net.MalformedURLException;
import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import com.godot.game.R;
import javax.microedition.khronos.opengles.GL10;
import com.google.ads.consent.*;

public class MySingleton extends Godot.SingletonBase {

    protected Activity appActivity;
    protected Context appContext;
    private Godot activity = null;
    private int instanceId = 0;
    private ConsentForm form;

    public String myFunction(String p_str) {
        // A function to bind.
        return "Hello " + p_str;
    }

    public void showConsentForm() {
        form = null;
        URL privacyUrl = null;
        try {
            // TODO: Replace with your app's privacy policy URL.
            privacyUrl = new URL("https://www.noisyleaf.co.uk/privacy_policy");
        } catch (MalformedURLException e) {
            e.printStackTrace();
            // Handle error.
        }
        final ConsentForm.Builder formBuilder = new ConsentForm.Builder(this.appActivity, privacyUrl)
            .withListener(new ConsentFormListener() {
                @Override
                public void onConsentFormLoaded() {
                    GodotLib.calldeferred(instanceId, "_on_consent_loaded", new Object[] { });
                    form.show();
                }

                @Override
                public void onConsentFormOpened() {
                    GodotLib.calldeferred(instanceId, "_on_consent_opened", new Object[] { });
                }

                @Override
                public void onConsentFormClosed(
                        ConsentStatus consentStatus, Boolean userPrefersAdFree) {
                    // Consent form was closed.
                    GodotLib.calldeferred(instanceId, "_on_consent_forward", new Object[] { consentStatus == ConsentStatus.PERSONALIZED });
                }

                @Override
                public void onConsentFormError(String errorDescription) {
                    GodotLib.calldeferred(instanceId, "_on_consent_error", new Object[] { errorDescription });
                }
            })
            .withPersonalizedAdsOption()
            .withNonPersonalizedAdsOption();

        activity.runOnUiThread(new Runnable() {    
            @Override public void run() {
                if (form == null) {
                    // build the form
                    form = formBuilder.build();

                    // load the form
                    form.load();
                }
            }
        });
    }

    public void init(int pInstanceId) {
        // You will need to call this method from Godot and pass in the get_instance_id().
        instanceId = pInstanceId;
        ConsentInformation consentInformation = ConsentInformation.getInstance(this.appActivity);
        String[] publisherIds = {"pub-6580148569317237"};
        consentInformation.requestConsentInfoUpdate(publisherIds, new ConsentInfoUpdateListener() {
            @Override
            public void onConsentInfoUpdated(ConsentStatus consentStatus) {
                // User's consent status successfully updated.
                GodotLib.calldeferred(instanceId, "_on_consent_success", new Object[] { });
                if (consentStatus == ConsentStatus.UNKNOWN) {
                    // Show form
                    GodotLib.calldeferred(instanceId, "_on_consent_unknown", new Object[] { });
                } else {
                    GodotLib.calldeferred(instanceId, "_on_consent_forward", new Object[] { consentStatus == ConsentStatus.PERSONALIZED });
                }
            }

            @Override
            public void onFailedToUpdateConsentInfo(String errorDescription) {
                // User's consent status failed to update.
                GodotLib.calldeferred(instanceId, "_on_consent_fail", new Object[] { errorDescription });
            }
        });
    }

    static public Godot.SingletonBase initialize(Activity p_activity) {
        return new MySingleton(p_activity);
    }

    public MySingleton(Activity p_activity) {
        // Register class name and functions to bind.
        registerClass("MySingleton", new String[]
            {
                "myFunction",
                "init",
                "showConsentForm"
            });
        this.appActivity = p_activity;
        this.appContext = appActivity.getApplicationContext();
        // You might want to try initializing your singleton here, but android
        // threads are weird and this runs in another thread, so to interact with Godot you usually have to do.
        this.activity = (Godot)p_activity;
        this.activity.runOnUiThread(new Runnable() {
            public void run() {
                // Useful way to get config info from "project.godot".
                String key = GodotLib.getGlobal("plugin/api_key");
                // SDK.initializeHere();
            }
        });
    }

    // Forwarded callbacks you can reimplement, as SDKs often need them.

    protected void onMainActivityResult(int requestCode, int resultCode, Intent data) {}
    protected void onMainRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {}

    protected void onMainPause() {}
    protected void onMainResume() {}
    protected void onMainDestroy() {}

    protected void onGLDrawFrame(GL10 gl) {}
    protected void onGLSurfaceChanged(GL10 gl, int width, int height) {} // Singletons will always miss first 'onGLSurfaceChanged' call.

}