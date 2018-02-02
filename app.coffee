axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'

module.exports =
	output: 'public'
	env: 'en'
	locals:
		env: 'en'
		basedir: 'views'
		md: require 'marked'
	
	ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

	extensions: [
		js_pipeline(files: ['assets/js/*.js','assets/js/*.coffee']),
		css_pipeline(files: ['assets/css/*.css','assets/css/*.styl'])
		contentful
			access_token:'74cacbafcaa3ea5e845b748967be91f6697e813b0e51272726505dc47d292a8c'
			space_id:'iqajn39axb7g'
			content_types:
				artists:
					id:'artist'
					filters:{
						'order':'fields.order'
					}
					template: '/views/partials/_artist.jade'
					path: (e) -> "artist/#{e.url}"
	]

	stylus:
		use: [axis(), rupture(), autoprefixer()]
		sourcemap: true

	'coffee-script':
		sourcemap: true

	jade:
		pretty: true

	server:
		clean_urls:true
