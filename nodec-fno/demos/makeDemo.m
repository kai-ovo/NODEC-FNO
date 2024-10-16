im_dir = "/Users/changkai/Desktop/2022_Moncrief/FNO/figs/burgers-time/ep200-lr0001-decay05/diff";
im_prefix = "epoch-";
demo_name = "./burgers-time/diff-ep200-lr0001-decay05";
epoch = 200;
idx_range = [0,epoch-1];
frame_rate = 3;
demoMaker(im_dir,im_prefix,idx_range,demo_name,frame_rate);