-- 製品ごとの月別売上金額を表示する
CREATE VIEW ProductSalesTrendView AS
SELECT
  p.product_id AS '製品ID',
  p.product_name AS '製品名',
  COALESCE(DATE_FORMAT(s.record_date, '%Y-%m'),'0000-00-00') AS '計上年月',
  ISNULL(SUM(od.quantity * od.unit_price * od.discount_rate)) AS '売上金額'
FROM
  product_master p
  LEFT OUTER JOIN order_details od ON p.product_id = od.product_id
  LEFT OUTER JOIN sales s ON od.order_id = s.order_id
GROUP BY
  p.product_id, p.product_name, DATE_FORMAT(s.record_date, '%Y-%m');
