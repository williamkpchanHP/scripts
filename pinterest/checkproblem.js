const { spawn } = require('child_process');

const child = spawn('node', ['your-script.js'], {
  stdio: 'inherit',
  shell: true,
});

child.on('error', (err) => {
  console.error('Failed to start subprocess:', err);
});

child.on('exit', (code) => {
  console.log(`Child process exited with code ${code}`);
});
