img  = imread('line.jpg');
subplot(221), imshow(img), title('original image');
img_gray = rgb2gray(img);
% the canny edge of image
BW = edge(img_gray,'sobel');
subplot(223), imshow(BW), title('image edge');
% the theta and rho of transformed space
[H,Theta,Rho] = hough(BW);
subplot(222), imshow(H,[],'XData',Theta,'YData',Rho,'InitialMagnification','fit'),...
    title('rho\_theta space and peaks');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
% label the top 5 intersections
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = Theta(P(:,2)); 
y = Rho(P(:,1));
plot(x,y,'*','color','r');

% find lines and plot them
lines = houghlines(BW,Theta,Rho,P,'FillGap',5,'MinLength',7);
figure, imshow(img), hold on
max_len = 0;
for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
end