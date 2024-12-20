%check JFs
x44=[BC(1:7);chart.x(1:192)];
JgetFs=coco_ezDFDX('f(x,p)', @getFs, x44,-9.8);
JgetJs=getJs(x44);
egetFs=(JgetJs-JgetFs)./JgetJs;
if any(egetFs(:) >0.01)
    jjj=1;
end

%check JFb
JgetFb=coco_ezDFDX('f(x,p)', @getFb,x44,0);
JgetJb=getJb(x44,m1,m2);
egetFb=(JgetFb-JgetJb)./JgetJb;

for i=1:1:199
    for j=1:1:199
if isnan(egetFb(i,j))
    egetFb(i,j)=0;
end
if isinf(egetFb(i,j))
    egetFb(i,j)=0;
end
    end
end

egetFbs=egetFb(1:199, 8:199);

for i=1:1:199
    for j=1:1:199
if -egetFb(i,j)>0.5
    ki=i
    kj=j
end
    end
end

%%
JgetFt=coco_ezDFDX('f(x,p)', @getFt, x44,refTIter);
JgetJt=getJt(x44,refTIter);
egetFt=(JgetFt-JgetJt)./JgetJt;

for i=1:1:199
    for j=1:1:199
if egetFt(i,j)>1
    ki=i
    kj=j
end
    end
end

%%
Numercial_J=coco_ezDFDX('f(x,p)', @Multi_segments_serpentine, chart.x(1:end-3),chart.x(end-1));
Formulation_J=Serpentine_dx(chart.x(1:end-3),chart.x(end-1));
relative_error=(Numercial_J-Formulation_J);%./Formulation_J;
%egetFt=(JgetFt-JgetJt)./JgetJt;
for i=1:1:682
    for j=1:1:682
if relative_error(i,j)>1
    ki=i
    kj=j
end
    end
end
