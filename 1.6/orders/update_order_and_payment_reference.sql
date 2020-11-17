# update the order reference of order with id 3276
# set a new reference to 'NEWREFXX'
# the order payments also get modified
#
# Beware than no other third parties tables references order.reference

START TRANSACTION;
set @new_ref="NEWREFXX";
set @id_order=3276;
select @old_ref:=reference from ps_orders where id_order=@id_order;
update ps_orders set reference=@new_ref where id_order=@id_order;
update ps_order_payment set order_reference=@new_ref where order_reference=@old_ref;
COMMIT;
