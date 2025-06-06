export interface AllowMeCapacitorPlugin {
  initialize(options: { apiKey: string }): Promise<void>;
  collect(): Promise<{ data: string }>;
}