pages_external_url "https://glaasts.ea.com/"
gitlab_pages['enable'] = true
gitlab_pages['access_control'] = true
gitlab_pages['redirect_http'] = true
pages_nginx['enable'] = true
pages_nginx['listen_port'] = 80
pages_nginx['listen_https'] = false
pages_nginx['proxy_set_headers'] = {
  "X-Real-IP" => "$remote_addr",
  "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
  "X-Forwarded-Proto" => "https",
  "X-Forwarded-Ssl" => "on",
}


pages_nginx['redirect_http_to_https'] = true

pages_nginx['custom_gitlab_server_config'] = <<-CONF
  if (\$http_x_forwarded_proto != "https") {
    rewrite ^(.*)\$ https://\$server_name\\$1 permanent;
  }
CONF