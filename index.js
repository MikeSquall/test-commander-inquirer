#!/usr/bin/env node

const program = require('commander');

const list = require('./lib/list');
const order = require('./lib/order');

program
  .command('list')
  .alias('ls')
  .description('A coffee list')
  .action(function () {
    list();
  });

program
  .command('order')
  .alias('o')
  .description('Order a coffee')
  .action(function () {
    order();
  });

program.parse(process.argv);
