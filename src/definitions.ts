export interface AllowMeCapacitorPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
