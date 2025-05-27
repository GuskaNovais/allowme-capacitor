package com.mycompany.plugins.example;

import android.content.Context;

import br.com.allowme.android.allowmesdk.AllowMe;
import br.com.allowme.android.allowmesdk.SetupCallback;
import br.com.allowme.android.allowmesdk.CollectCallback;

public class AllowMeCapacitor {
    private AllowMe mAllowMe;

    public void initialize(Context context, String apiKey, final SetupCallback callback) {
        if (mAllowMe == null) {
            mAllowMe = new AllowMe(context, apiKey);
            mAllowMe.setup(new SetupCallback() {
                @Override
                public void success() {
                    callback.success();
                }

                @Override
                public void error(Throwable throwable) {
                    callback.error(throwable);
                }
            });
        }
    }

    public void collect(final CollectCallback callback) {
        if (mAllowMe != null) {
            mAllowMe.collect(new CollectCallback() {
                @Override
                public void success(String collection) {
                    callback.success(collection);
                }

                @Override
                public void error(Throwable throwable) {
                    callback.error(throwable);
                }
            });
        } else {
            callback.error(new Throwable("SDK not initialized"));
        }
    }
}
