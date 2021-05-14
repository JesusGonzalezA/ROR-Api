json.extract! movimiento, :id, :importe, :fecha_hora, :cuenta_id, :created_at, :updated_at
json.url movimiento_url(movimiento, format: :json)
