var casper = require('casper').create();
var screenshotUrl;

if (casper.cli.args.length < 1) {
  casper
    .echo("Usage: $ casperjs main.js http://example.com")
    .exit(1);
} else {
  screenshotUrl = casper.cli.args[0];
}


casper
  .start(screenshotUrl)
  .thenEvaluate(function() {
    document.body.bgColor = 'white';
  })
  .then(function() {
    var ts = Date.now()
    var filepath = 'screenshots/' + ts + '.png';
    this.capture(filepath);
    console.log(filepath);
  });

casper.run();
