package com.mycompany.plugins.example;

import android.content.Context;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.PluginMethod;

import br.com.allowme.android.allowmesdk.SetupCallback;
import br.com.allowme.android.allowmesdk.CollectCallback;

@CapacitorPlugin(name = "AllowMeCapacitor")
public class AllowMeCapacitorPlugin extends Plugin {

    private AllowMeCapacitor allowMe;

    @PluginMethod
    public void initialize(PluginCall call) {
        String apiKey = call.getString("apiKey");

        if (apiKey == null || apiKey.isEmpty()) {
            call.reject("API Key is required.");
            return;
        }

        getActivity().runOnUiThread(() -> {
            allowMe = new AllowMeCapacitor();

            allowMe.initialize(getContext(), apiKey, new SetupCallback() {
                @Override
                public void success() {
                    call.resolve();
                }

                @Override
                public void error(Throwable throwable) {
    
                    call.reject("Initialization failed", new Exception(throwable));
                }
            });
        });
    }

    @PluginMethod
    public void collect(PluginCall call) {
        if (allowMe == null) {
            call.reject("SDK not initialized.");
            return;
        }

        allowMe.collect(new CollectCallback() {
            @Override
            public void success(String collection) {
                JSObject ret = new JSObject();
                ret.put("data", collection);
                call.resolve(ret);
            }

            @Override
            public void error(Throwable throwable) {

                call.reject("Collect failed", new Exception(throwable));
            }
        });
    }
}
