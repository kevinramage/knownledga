import Fastify from 'fastify';
import cors from '@fastify/cors';
import { WorkspaceBusiness } from './business/workspaceBusiness.ts';
import { DocumentBusiness } from './business/documentBusiness.ts';

export const fastify = Fastify({
  logger: true
})

// Add JSON parser
fastify.addContentTypeParser('application/json', { parseAs: 'string' }, function (_, body, done) {
  try {
    var json = JSON.parse(body + "")
    done(null, json)
  } catch (err: any) {
    err.statusCode = 400
    done(err, undefined)
  }
})

// Open a workspace from name
fastify.get('/api/v1/workspace/:name', async function handler (request, reply) {
  const name = (request.params as any)["name"];
  const workspace = await WorkspaceBusiness.readWorkspace(name);
  return workspace;
});

// Open workspace list
fastify.get('/api/v1/workspace/', async function handler (_, reply) {
  const workspaces = await WorkspaceBusiness.readWorkspaces();
  return workspaces;
});

// Read document from path
fastify.post('/api/v1/document/', async function handler(request, reply) {
  const data = request.body as { path: string };
  const document = await DocumentBusiness.readDocument(data.path);
  return document;
})

fastify.get('/api/v1/ping', async function handler (request, reply) {
  return { status: "OK" }
});

// Cors
//fastify.register(cors, { origin: ['http://localhost:1420', 'http://localhost:5173', 'https://tauri.localhost'] })
fastify.register(
  cors,
  {
    origin: ['http://localhost:1420', 'http://localhost:5173', 'https://tauri.localhost'],
  }
);

// Run the server!
/*
fastify.listen({ port: 3000}).then(() => {
    console.info("Listenning");
}).catch((err) => {
    console.error(err)
    process.exit(1)
});
*/
(async () => {
  try {
    console.info("Run server ...")
    const info = await fastify.listen({ port: 3001 });
    console.log(info);
  } catch (err) {
    console.info("Error during server execution ...", err);
    fastify.log.info(err);
    process.exit(1);
  }
});

const start = async () => {
  try {
    await fastify.listen({ port: 3000 })
  } catch (err) {
    fastify.log.error(err)
    //process.exit(1)
  }
}
start()