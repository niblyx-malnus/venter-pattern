import memoize from "lodash/memoize";
import Urbit from "@urbit/http-api";

const ship = "tomsug-nalwet-niblyx-malnus";

const api = {
  createApi: memoize(() => {
      const urb = new Urbit("http://localhost:8080", "");
      urb.ship = ship;
      urb.onError = (message) => console.log("onError: " + message);
      urb.onOpen = () => console.log("urbit onOpen");
      urb.onRetry = () => console.log("urbit onRetry");
      urb.connect(); 
      return urb;
  }),
  scry: async (app: string, path: string) => {
    return api.createApi().scry({ app: app, path: path});
  },
  poke: async (app: string, mark: string, json: any) => {
    try {
    return api.createApi().poke({
      app: app,
      mark: mark,
      json: json,
    });
    } catch (e) {
      console.log("poke error");
    }
  },
  vent: async (vnt: any, desk: string) => {
    const result: any = await api.createApi().thread({
      inputMark: 'vent-package', // input to thread, contains poke
      outputMark: 'json',
      threadName: 'venter',
      body: {
        dock: {
          ship: vnt.ship,
          dude: vnt.dude,
        },
        input: {
          desk: vnt.inputDesk,
          mark: vnt.inputMark, // mark of the poke itself
        },
        output: {
          desk: vnt.outputDesk,
          mark: vnt.outputMark,
        },
        body: vnt.body,
      },
      desk: desk,
    });
    if (
      result !== null &&
      result.term &&
      result.tang &&
      Array.isArray(result.tang)
    ) {
      throw new Error(`\n${result.term}\n${result.tang.join('\n')}`);
    } else {
      return result;
    }
  },
  exampleAction: async (json: any) => {
    return await api.vent({
      ship: ship, // the ship to poke
      dude: 'venter-example', // the agent to poke
      inputDesk: 'venter', // where does the input mark live
      inputMark: 'example-action', // name of input mark
      outputDesk: 'venter', // where does the output mark live
      outputMark: 'example-vent', // name of output mark
      body: json, // the actual poke content
    }, 'venter');
  },
  createDatum: async (t: string) => {
    const json = { "create-datum": { t: t } };
    return await api.exampleAction(json);
  },
  deleteDatum: async (id: string) => {
    const json = { "delete-datum": { id: id } };
    return await api.exampleAction(json);
  },
  createAndDelete: async (t: string) => {
    const json = { "create-and-delete": { t: t } };
    return await api.exampleAction(json);
  },
}

export default api;