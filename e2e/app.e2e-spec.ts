import { Monograder2Page } from './app.po';

describe('monograder2 App', function() {
  let page: Monograder2Page;

  beforeEach(() => {
    page = new Monograder2Page();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
