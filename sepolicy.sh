# file
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } vendor_display_prop file { read open getattr map }"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } vendor_display_prop file { read open getattr map }"
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } sysfs file { open getattr }"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } sysfs file { open getattr }"
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } app_data_file file execute"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } app_data_file file execute"
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } proc_stat file { open read }"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } proc_stat file { open read }"
magiskpolicy --live "dontaudit zygote device file { write open }"
magiskpolicy --live "allow     zygote device file { write open }"
magiskpolicy --live "dontaudit magisk system_lib_file file ioctl"
magiskpolicy --live "allow     magisk system_lib_file file ioctl"
magiskpolicy --live "dontaudit crash_dump packagemanager_config_prop file { open getattr map }"
magiskpolicy --live "allow     crash_dump packagemanager_config_prop file { open getattr map }"
magiskpolicy --live "dontaudit crash_dump media_variant_prop file { open getattr }"
magiskpolicy --live "allow     crash_dump media_variant_prop file { open getattr }"

# dir
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } blkio_dev dir search"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } blkio_dev dir search"
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } app_data_file dir { getattr search }"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } app_data_file dir { getattr search }"

# service_manager
magiskpolicy --live "allow { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } default_android_service service_manager find"

# binder
magiskpolicy --live "dontaudit { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } hal_memtrack_default binder call"
magiskpolicy --live "allow     { system_app priv_app platform_app untrusted_app_29 untrusted_app_27 untrusted_app } hal_memtrack_default binder call"


