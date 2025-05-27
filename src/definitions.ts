export interface AllowMeCapacitorPlugin {
  initialize(options: { apiKey: string }, environment: 'hml'): Promise<void>;
  collect(): Promise<{ data: string }>;
}