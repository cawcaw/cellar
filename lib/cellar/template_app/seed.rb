test_site = Cellar::Site.new
test_site.name = 'test'
test_site.domain = 'test.dev'
test_site.save

test_page = Cellar::Page.new
test_page.slug = 'page1'
test_page.template = 'article'
test_page.content = ['text content']
test_page.save

test_page = Cellar::Page.new
test_page.slug = 'page2'
test_page.template = 'articl'
test_page.content = ['text content']
test_page.save
