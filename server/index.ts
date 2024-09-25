import Fastify from 'fastify';
import cors from '@fastify/cors';

const fastify = Fastify({
  logger: true
})

// Declare a route
fastify.get('/', async function handler (request, reply) {
  return { hello: 'world' }
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
    const info = await fastify.listen({ port: 3000 });
    console.log(info);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
})();