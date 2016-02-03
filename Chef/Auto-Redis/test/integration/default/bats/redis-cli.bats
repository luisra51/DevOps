@test "redis-cli revisando si el binario se encuentra en el directorio" {
  run which redis-cli
  [ "$status" -eq 0 ]
}
