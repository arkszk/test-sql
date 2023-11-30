-- 部署ごとの月別売上金額（見込み含む）を表示する
CREATE VIEW department_sales_by_month_view AS
SELECT
  s.dept_id AS '部署ID',
  d.dept_name AS '部署名',
  DATE_FORMAT(s.record_date, '%Y-%m') AS '年月',
  SUM(s.total_amount) AS '合計売上金額'
FROM
  Sales s
  LEFT OUTER JOIN dept_master d ON s.dept_id = d.dept_id
GROUP BY
  s.dept_id, d.dept_name, DATE_FORMAT(s.record_date, '%Y-%m');