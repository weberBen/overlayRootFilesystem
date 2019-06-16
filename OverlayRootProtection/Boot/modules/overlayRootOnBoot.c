#include<linux/module.h>
#include<linux/init.h>
#include<linux/proc_fs.h>
#include<linux/sched.h>
#include<linux/uaccess.h>
#include<linux/fs.h>
#include<linux/seq_file.h>
#include<linux/slab.h>

#define PROC_ENTRY_NAME "overlayRootOnBoot"

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Save user answer on boot about mouting overlay on root filesystem");
MODULE_VERSION("0.01");

static char *str = NULL;

static int my_proc_show(struct seq_file *m,void *v){
	seq_printf(m,"%s",str);
	return 0;
}

static ssize_t my_proc_write(struct file* file,const char __user *buffer,size_t count,loff_t *f_pos){
	char *tmp = kzalloc((count+1),GFP_KERNEL);
	if(!tmp)return -ENOMEM;
	if(copy_from_user(tmp,buffer,count)){
		kfree(tmp);
		return EFAULT;
	}
	kfree(str);
	str=tmp;
	return count;
}

static int my_proc_open(struct inode *inode,struct file *file){
	return single_open(file,my_proc_show,NULL);
}

static struct file_operations my_fops={
	.owner = THIS_MODULE,
	.open = my_proc_open,
	.release = single_release,
	.read = seq_read,
	.llseek = seq_lseek,
	.write = my_proc_write
};

static int __init mod_init(void){
	struct proc_dir_entry *entry;
	entry = proc_create(PROC_ENTRY_NAME,0744,NULL,&my_fops);
	if(!entry)
	{
		return -1;	
	}
	return 0;
}

static void __exit mod_exit(void){
	remove_proc_entry(PROC_ENTRY_NAME,NULL);
}

module_init(mod_init);
module_exit(mod_exit);
