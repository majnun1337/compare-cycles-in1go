%% number of files
n=23;
%% Get data
for i=1:n
    in_fid=fopen(ext_file(i,'.lvm'), 'r');                 % Open LVM file.
    if in_fid < 0
        break;
    end
    for m = 1:24                                    % Header lines count.
        fgetl(in_fid) ;                             % Read line.
    end;                                            % Pointing at
    buffer = fread(in_fid, Inf) ;                   % Read rest of the file.
    fclose(in_fid);
    in_fid = fopen(file_name('datafile',i),'w');    % Open data-only file.
    fwrite(in_fid, buffer) ;                        % Save to file.
    fclose(in_fid);
    clear buffer;
    out_fid=dlmread(file_name('datafile',i),'\t');
    wrt=out_fid(1:end,2:3);
    xlswrite(num2str(i),wrt);
end

%% Plot data
for j=1:n
data1= xlsread(ext_file(j,'.xls'));
figure
h=plot(smooth(data1(:,1)),smooth(data1(:,2)));
savefig(ext_file(j,'plot'));
saveas(h,ext_file(j,'plot'),'jpeg');
close
end