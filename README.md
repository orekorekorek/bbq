# bbq
Web app for managing events. Create events, subscribe to them, comment on them, attach photos, restrict access to them.

## Technology stack
Backend:
* Rails 7
* Yandex Cloud bucket for storaging photos
* Resque workers
* Email sending via Mailjet
* OAuth via GitHub and Yandex

Frontend:
* Lightbox2
* Yandex maps

## Launching
1. Clone repo
1. Install `libvips`
1. Use bundler
1. Setup your API keys:
>__credentials.yml.enc__
>```
>secret_key_base:
>
>yc:
>  access_key_id:
>  secret_access_key:
>
>yandex_maps_api_key: 
>
>development:
>  omniauth_gh_id: 
>  omniauth_gh_secret: 
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>
>test:
>  omniauth_gh_id: 
>  omniauth_gh_secret: 
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>
>production:
>  omniauth_gh_id: 
>  omniauth_gh_secret: 
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>```
5. Setup your psql
1. Change `database.yml`
1. Create a new database and run migrations
1. Run workers `QUEUE=bbq* bundle exec rake environment resque:work`
1. Run application
1. Enjoy

Also you can deploy it via capistrano (configure it for your vps before).
