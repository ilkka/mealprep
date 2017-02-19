/// <reference path="./lokka-transport-http.d.ts" />

declare interface LokkaOptions {
  transport: Transport
}

declare class Lokka {
  constructor(options: LokkaOptions)
  query<T>(qstr: string, vars?: { [key: string]: any }): Promise<T>
  mutate<T>(qstr: string, vars?: { [key: string]: any }): Promise<T>
}

declare module "lokka" {
  export default Lokka
}
