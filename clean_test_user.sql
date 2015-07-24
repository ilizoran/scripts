delete FROM otrs_3_4.user_preferences where user_id > 11;
delete FROM otrs_3_4.group_user where user_id > 11;
delete FROM otrs_3_4.users where user_id > 11;
delete FROM otrs_3_4.customer_user where user_id > 10;