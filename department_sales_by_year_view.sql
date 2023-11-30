-- 部署ごとの年度別売上金額を表示する
CREATE VIEW department_sales_by_year_view AS
SELECT
  s.dept_id AS '部署ID',
  d.dept_name AS '部署名',
  SUM(s.total_amount) AS '合計売上金額',
  SUM(s.expense_amount) AS '合計経費金額',
  SUM(s.gross_profit_amount) AS '合計粗利金額',
  s.year AS '年度'
FROM
  (SELECT
    order_id,
    dept_id,
    total_amount,
    expense_amount,
    gross_profit_amount,
    DATE_FORMAT(DATE_SUB(record_date,INTERVAL 3 MONTH), '%Y') AS year
  FROM sales
  ) AS s
  LEFT OUTER JOIN orders o ON s.order_id = o.order_id
  LEFT OUTER JOIN dept_master d ON s.dept_id = d.dept_id
WHERE
  o.order_status = '完了'
GROUP BY
  s.dept_id, d.dept_name, s.year;