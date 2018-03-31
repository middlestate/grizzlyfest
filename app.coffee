axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'
subPages     = {}
featuredArtists = []
transformFunction = (entry) ->
	subPages[entry.id] = entry
getDateVars = (entry) ->
	if entry.playing.fields.timeSlot != undefined
		days = ["","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
		months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
		date = new Date(entry.playing.fields.timeSlot)
		entry.dateFormatted = {}
		entry.dateFormatted.day = date.getDate()
		entry.dateFormatted.dayName = days[date.getDay()]
		entry.dateFormatted.month = months[date.getMonth()]
		entry.dateFormatted.year = date.getFullYear()
		entry.dateFormatted.hour = if date.getHours() >= 12 then date.getHours() - 12 else date.getHours()
		if entry.dateFormatted.hour == 0
			entry.dateFormatted.hour = 12
		entry.dateFormatted.ampm = if date.getHours() >= 12 then "PM" else "AM"
		entry.dateFormatted.minutes = if date.getMinutes() < 10 then '0' + date.getMinutes() else date.getMinutes
		console.log(JSON.stringify(entry.dateFormatted))
module.exports =
	output: 'public'
	env: 'en'
	locals:
		env: 'en'
		basedir: 'views'
		md: require 'marked'
		subPages:subPages

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
					transform: getDateVars
					template: '/views/partials/_artist.jade'
					path: (e) -> "artist/#{e.url}"
				featuredArtists:
					id:"artist"
					filters:{
						"fields.featured[exists]":"true"
						"order":"fields.featured"
					}
					template: '/views/partials/_artist.jade'
					path: (e) -> "artist/#{e.url}"
					transform: getDateVars
				subPages:
					id:'subPage'
					transform:transformFunction
					template: '/views/partials/_subPage.jade'
					path: (e) -> "/#{e.id}"
				blog:
					id:"blog"
					filters:{
						'order':'-fields.date'
					}
					template: '/views/partials/_blog-post.jade'
					path: (e) -> "blog/#{e.id}"
				events:
					id:"event"
					filters:{
						'order':'fields.tempOrder'
					}
					template: '/views/partials/_event.jade'
					path: (e) -> "event/#{e.id}"
				eventCategories:
					id:"eventCategory"
					filters:{
						'order':'fields.order'
					}
				home:
					id:"homePage"
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
