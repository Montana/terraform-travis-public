data "grpc_request" "get_version_info" {
  address = "grpc-server.com:443"
  method  = "org.service.Service.GetVersionInfo"
}

data "grpc_request" "list_resources" {
  address = "grpc-server.com:443"
  method  = "org.service.Service.ListResources"

  request_headers = {
    "client-api-protocol" = "1,1"
    "authorization"       = var.auth_token
  }
}
