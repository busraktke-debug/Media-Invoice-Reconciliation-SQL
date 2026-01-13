/* PROJECT: Media Invoice Reconciliation
Logic: Comparing planned budget vs actual invoices to catch over/underspends.
*/

SELECT 
    p.Campaign_Name,
    p.Planned_Budget,
    f.Approved_Invoice,
    -- Variance calculation
    ROUND(p.Planned_Budget - f.Approved_Invoice, 2) AS Variance_Amount,
    -- Mental Model: Categorizing the status
    CASE 
        WHEN f.Approved_Invoice IS NULL THEN 'Missing Invoice'
        WHEN p.Planned_Budget < f.Approved_Invoice THEN 'Overspend'
        WHEN p.Planned_Budget > f.Approved_Invoice THEN 'Underspend'
        ELSE 'Matched'
    END AS Audit_Status
FROM planned_spend p
LEFT JOIN actual_invoices f ON p.Campaign_ID = f.Campaign_ID;
