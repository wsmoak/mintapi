# export MINT_EMAIL=someone@example.com

python mintapi/api.py --keyring --mfa-method=email --transactions --filename=transactions.csv $MINT_EMAIL

csvsql --query "select date,description,amount,transaction_type,category,account_name from transactions where date between '2020-07-01' and '2020-07-31'" transactions.csv > current.csv

csvsql --query "select transaction_type,amount from current where category != 'credit card payment'" current.csv | csvsql --query "select transaction_type, sum(amount) from STDIN group by transaction_type order by transaction_type" > output.csv

cat output.csv
