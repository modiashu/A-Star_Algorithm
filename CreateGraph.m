%% File name: CreateGraph.m
%  Author: Palak Dave, Ashutosh Modi
%  Description: This is the main file to run A-Star algorithm.
%               File acquire required inputs from command prompt and 
%               displays path from origin to destination based on the 
%               heuristic chosen.
%  Date: Oct 15, 2017.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create a graph
clear all; clc; close all

%% Initialize variables for Graph
global networkData;
global heuristic;
global startNode;
global destNode;

networkData= {zeros()};

%% Get user inputs

% Node names
%startNode = 'A1'; %For debugging purpose
startNode = input('Type start node name (Case sensitive) & hit Enter : ','s');
%destNode = 'G2'; %For debugging purpose
destNode = input('Type destination node name (Case sensitive) & hit Enter : ','s');
disp('---------------------------------------------------------');

% Heuristic to choose; 1=straight line distance; 2=fewest links
%heuristic = 2; %For debugging purpose
heuristic = input('--Select heuristic--\nChoose number & hit Enter\n1 straight line distance\n2 fewest links\n: ');
if(1~=heuristic && 2~=heuristic)
    disp('Entered heuristic value is not valid.');
    return;
end
disp('---------------------------------------------------------');

% Node connections file Reading
%networkData = ConnectionsReading('connections.txt', networkData);
[connFileName,connPathName,FilterIndex] = uigetfile('../*.txt', 'Select connections text file');
%valid = ConnectionsReading('connections.txt'); %For debugging purpose
if(FilterIndex ~= 1)
    disp('Invalid connections file or path!!');
    return;
end
valid = ConnectionsReading(strcat(connPathName,connFileName));
if(false == valid)
    return;
end

% Node locations file reading
% networkData = LocationReading('locations.txt', networkData);
[locFileName,locPathName,FilterIndex] = uigetfile('../*.txt', 'Select locations text file');
if(FilterIndex ~= 1)
    disp('Invalid locations file or path!!');
    return;
end
%valid = LocationReading('locations.txt'); %For debugging purpose
valid = LocationReading(strcat(locPathName,locFileName));
if(false == valid)
    return;
end

%% Check if start and destination nodes are valid
valid = ValidateData();
if(false == valid)
    return;
end

%% Exclude cities
Exclusion();

%% Create directional graph entities (nodes, edges)
% [sourceNodes, terminatingNodes, edgeWeight] = CreateGraphEntities(networkData);
global sourceNodes;
global terminatingNodes;
global edgeWeight;
[sourceNodes, terminatingNodes, edgeWeight] = CreateGraphEntities();

%% Create directional graph and plot
% Commented for GUI part-2 of the project
global p;
p=digraph(sourceNodes,terminatingNodes,edgeWeight);
%plot(p,'EdgeLabel',edgeWeight,'XData',str2double(networkData(:,4)),'YData',str2double(networkData(:,5)));%,'EdgeColor',rand(82,3));
%set(gca,'YDir','reverse');


%% A Star algorithm

valid = AStar();
if(false == valid)
    disp('No path found.');
    return;
end
