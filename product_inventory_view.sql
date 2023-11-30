-- 商品ごとの在庫状況を表示する
CREATE VIEW product_inventory_view AS
SELECT
  p.product_id AS '製品ID',
  p.product_name AS '製品名',
  ISNULL(i.quantity_on_hand) AS '在庫数',
  COALESCE(i.update_date,'0000-00-00') AS '最終更新日'
FROM
  product_master p
  LEFT OUTER JOIN (
    SELECT
        a.product_id,
        a.quantity_on_hand,
        a.update_date
    FROM inventory a
    INNER JOIN (
        SELECT
            product_id,
            MAX(update_date) AS update_date
        FROM inventory
        GROUP BY product_id
    ) AS b ON a.product_id = b.product_id
    AND a.update_date = b.update_date
  ) AS i ON p.product_id = i.product_id;


