import { WebPlugin } from '@capacitor/core';

import type { AllowMeCapacitorPlugin } from './definitions';

export class AllowMeCapacitorWeb extends WebPlugin implements AllowMeCapacitorPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
