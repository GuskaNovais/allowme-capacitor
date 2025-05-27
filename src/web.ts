import { WebPlugin } from '@capacitor/core';

import type { AllowMeCapacitorPlugin } from './definitions';

export class AllowMeCapacitorWeb extends WebPlugin implements AllowMeCapacitorPlugin {
  async initialize(options: { apiKey: string; environment: 'hml' | 'prod' }): Promise<void> {
    console.log('AllowMe Web: initialize with', options.apiKey);
  }

  async collect(): Promise<{ data: string }> {
    console.log('AllowMe Web: collect');
    return { data: 'web-collection-result' };
  }
}
