export interface AllowMeCapacitorPlugin {
  initialize(options: { apiKey: string }, environment: 'hml' | 'prod'): Promise<void>;
  collect(): Promise<{ data: string }>;
}