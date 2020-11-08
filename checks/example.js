Feature('testcheck');

Scenario('test something', ({ I }) => {
    I.amOnPage(process.env.BASE_URL)
    I.see("example")
});
