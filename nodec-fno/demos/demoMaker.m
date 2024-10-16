function demoMaker(im_dir,im_prefix,idx_range,demo_name,frame_rate,demo_dir)
%
% @kaichang@mit.edu
%
% Input:
%       im_dir - relative/absolute directory of the images
% 
%       im_prefix - prefix of image names; i.e. the part of the names 
%                   without number indecies); assumed to be the same for
%                   all images with which the demo is made
% 
%       idx_range - a 2-tuple of integers [low, high] specifying the index
%                  range for the images
%       
%       demo_name - file name for the demo
%
%       frame_rate - frames per second
% 
%       demo_dir - directory to store the demo
%                   
%
if nargin < 6
    demo_dir = "./";
end
if nargin < 5
    frame_rate = 10;
end
if extract(im_dir,strlength(im_dir)) ~= "/"
    im_dir = strcat(im_dir, "/");
end
if extract(demo_dir,strlength(demo_dir)) ~= "/"
    demo_dir = strcat(demo_dir, "/");
end
if extractAfter(demo_name,strlength(demo_name)-4) ~= ".mp4"
    demo_name = strcat(demo_name, ".mp4");
end

demo_name = demo_dir + demo_name;

low = idx_range(1);
high = idx_range(2);

video = VideoWriter(demo_name,'MPEG-4');
video.FrameRate = frame_rate;
open(video);

for i=low:high
    img = im_dir + im_prefix + num2str(i) + '.png';
    I = imread(img);
    writeVideo(video,I);
end

close(video);
    