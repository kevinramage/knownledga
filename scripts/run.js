import { exec } from "child_process";
import { execa } from "execa";

async function killNode() {
    console.info("- Kill old process");
    return execa("powershell", ["kill", "(Get-Process -Name node).Id"]).stdout.pipe(process.stdout);
}

async function createBundle() {
    console.info("- Compiling");
    return execa('node_modules/.bin/esbuild', [
        './server', '--bundle', '--outfile=dist/server.cjs', '--platform=node'
    ]).stdout.pipe(process.stdout);
}
function runNode() {
    return new Promise((resolve) => {
        console.info("- Running");
        execa("node dist/server.cjs", [], {}).then(() => {
            console.info("Done");
        });
        /*
        const execution = exec("node dist/server.cjs", {}, ((err, stdout, sderr) => {
            console.info("*** End of execution");
            //resolve();
        }));
        execution.stdout.pipe(process.stdout);
        execution.stderr.pipe(process.stderr);
        */
    });
}

function run() {
    return new Promise(async (resolve) => {
        console.info("*** Start");
        await createBundle();
        await killNode();
        await runNode();
        console.info("*** End");
        resolve();
    });
}

await run();