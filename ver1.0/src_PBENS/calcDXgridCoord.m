function  [gridCoord] = calcDXgridCoord(dime,delta,origin)
%% constants
    dix = dime(1);
    diy = dime(2);
    diz = dime(3);
    %% grid points--ant60Ef15 backbone NH distance calculation
    coord = zeros(dix * diy * diz,3);
    % grid space
    dx = delta(1);
    dy = delta(2);
    dz = delta(3);
    % basic elements for grid point coordinates
    xcor = origin(1).*ones(dix,1)+dx.*[(1:1:dix)-1]';
    ycor = origin(2).*ones(diy,1)+dy.*[(1:1:diy)-1]';
    zcor = origin(3).*ones(diz,1)+dz.*[(1:1:diz)-1]';
    % constructing coordinates for all grid points according to DX file format
    xC = repmat(xcor', diy*diz, 1);
    xx = xC(:);
    yC1 = repmat(ycor', diz^1, 1);
    yy = repmat(yC1(:), dix^1, 1);
    zC = repmat(zcor, dix * diy, 1);
    zz = zC(:);
    gridCoord = [xx yy zz];
    
end