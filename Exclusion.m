%% File name: Exclusion.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Implements functionality of node exclusion. User specified
%               nodes are excluded from A* algorithm for path finding.
%
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function Exclusion()
    global networkData;
    global startNode;
    global destNode;
    %get cities to exclude
    isExclude=input('Do you want to exclude any node?\nPress 1 for Yes\n      0 for No\n:');
    if(isExclude)
        excludeCities=cell(0,0);
        doloop=true;
        while doloop 
            tempCityName=input('Type a node name to exclude(Case sensitive) & hit Enter :','s');
            if(~isempty(tempCityName))
                if(strcmp(tempCityName, startNode))
                    disp('"Exclude node name is same as start node; Please choose another to exclude."');
                elseif(strcmp(tempCityName, destNode))
                    disp('"Exclude node name is same as dest node; Please choose another to exclude."');
                else
                    excludeCities=[excludeCities tempCityName];
                end
            else
                break;
            end

            if ~input('\n--Press & hit Enter-- \n1 to continue adding exclusions\n0 to exit\n: ')
                doloop=false;
            end
        end

        %exclude the links
        for excldNo=1:size(excludeCities,2)
            for row=1:size(networkData,1)
                cellNo=1;
                while cellNo<=str2double(networkData{row,2})
                    if strcmp(excludeCities(1,excldNo),networkData{row,3}{1,1}{1,cellNo})
                        networkData{row,3}{1,1}(:,cellNo)=[];
                        networkData{row,2}=num2str(str2double(networkData{row,2})-1);
                        cellNo=cellNo-1;
                    end
                    cellNo=cellNo+1;
                end
            end
        end
    else
        return
    end
end