-- 顧客ごとの製品購入履歴を表示する
CREATE VIEW customer_purchase_history_view AS
SELECT
  c.customer_id AS '顧客ID',
  c.customer_name AS '顧客名',
  o.order_id AS '注文ID',
  o.order_date AS '注文日',
  p.product_name AS '製品名',
  od.quantity AS '購入数',
  od.quantity * od.unit_price * od.discount_rate AS '合計金額'
FROM
  customer_master c
  LEFT OUTER JOIN orders o ON c.customer_id = o.customer_id
  LEFT OUTER JOIN order_details od ON o.order_id = od.order_id
  LEFT OUTER JOIN product_master p ON od.product_id = p.product_id;