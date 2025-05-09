import { registerPlugin } from '@capacitor/core';

import type { AllowMeCapacitorPlugin } from './definitions';

const AllowMeCapacitor = registerPlugin<AllowMeCapacitorPlugin>('AllowMeCapacitor', {
  web: () => import('./web').then((m) => new m.AllowMeCapacitorWeb()),
});

export * from './definitions';
export { AllowMeCapacitor };
