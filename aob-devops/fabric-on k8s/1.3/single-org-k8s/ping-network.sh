echo "Testing Inventory Mmanagement"
composer network ping -c erpinventoryadmin@aob-erp-inventory-mgmt
echo "Testing Order Management"
composer network ping -c erporderadmin@aob-erp-order-mgmt
echo "Testing Sales Management"
composer network ping -c erpsalesinvoiceadmin@aob-sales-invoice
echo "Testing Labs Management"
composer network ping -c erplabadmin@aob-labs
