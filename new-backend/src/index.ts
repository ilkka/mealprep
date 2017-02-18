import * as Hapi from "hapi";
import * as Joi from "joi";
import * as loadJsonFile from "load-json-file";

const pack = loadJsonFile.sync("../package.json");

const server = new Hapi.Server();
server.connection({ port: process.env.PORT || 3000 });

interface Meal {
  id: number;
  name: string;
}

/**
 * A definition for a "register" function that can also have
 * attributes set on it.
 */
interface RegisterHandler {
  attributes?: { [key: string]: any };
  (srv: Hapi.Server, options: any, next: Function): void;
}

/**
 * Hapi plugin using the register function interface from above.
 */
interface Plugin {
  register: RegisterHandler;
}

function mealsHandler(request: Hapi.Request, reply: Hapi.IStrictReply<Meal[]>) {
  reply([
    { id: 1, name: "Kalasoppa" },
    { id: 2, name: "Lihapullat" },
    { id: 3, name: "Maksalaatikko" },
  ]);
}

// The app plugin
const App: Plugin = {
  register: (srv: Hapi.Server, options: any, next: Function) => {
    srv.route({
      config: {
        response: {
          schema: Joi.array().items(Joi.object({
            id: Joi.number().description("Meal ID"),
            name: Joi.string().description("Meal name"),
          })),
        },
        validate: {},
      },
      handler: mealsHandler,
      method: "GET",
      path: "/meals",
    });
    next();
  },
};

App.register.attributes = {
  name: "mealprep-backend",
  version: pack.version,
};
