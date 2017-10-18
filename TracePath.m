%% File name: TracePath.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: Displayes found path by backtracking.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function defination
function TracePath()
    global parentLinkMap;
    global destNode;
    path = {destNode};
    nodeItr = destNode;
    while(~(isempty( parentLinkMap(char(nodeItr)))))
        path = [parentLinkMap(char(nodeItr)) '->' path];
        nodeItr = parentLinkMap(char(nodeItr));
    end
    
    disp('Path is as follows:');
    %fprintf('Start ->');
    for str = path
        fprintf('%s ',str{1});
    end
    %disp('End');
    fprintf('\n ');
end