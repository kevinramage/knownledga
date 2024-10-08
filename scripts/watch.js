/**
 * This script is used to rename the binary with the platform specific postfix.
 * When `tauri build` is ran, it looks for the binary name appended with the platform specific postfix.
 */

import { execa } from 'execa';
import chokidar from 'chokidar'


async function build() {
  try {
    await execa('node', ['scripts/run.js'], { all: true }).stdout.pipe(process.stdout);
  } catch (e) {
    console.error(e);
  }
}


async function watch() {
  const watcher = chokidar.watch('server/*', {
    ignored: /(^|[\/\\])\../, // ignore dotfiles
    persistent: true
  });
  
  watcher.on('change', build);

  build();
}

watch().catch((e) => {
  throw e
});