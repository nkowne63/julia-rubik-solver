module rawCube
using Match
import Base: *

@enum Axis x = 0 y = 1 z = 2
@enum Rotation right = -1 left = 1

*(axis::Axis, rotation::Rotation) = Axis((Int(rotation) + Int(axis) + 3) % 3)

struct AxisRotation
    axis::Axis
    rotation::Rotation
end

@enum Sign positive = 1 negative = -1

*(s1::Sign, s2::Sign) = Sign(Int(s1) * Int(s2))
*(s::Sign, r::Rotation) = Sign(Int(s) * Int(r))

# axis1を中心にaxis2をleft回転させたときの向き
other(axis1::Axis, axis2::Axis) = @match (Int(axis1), Int(axis2)) begin
    (0, 1) => (z, positive)
    (1, 0) => (z, negative)
    (1, 2) => (x, positive)
    (2, 1) => (x, negative)
    (2, 0) => (y, positive)
    (0, 2) => (y, negative)
    _ => (axis2, positive)
end


struct Face
    axis::Axis
    sign::Sign
end

*(face::Face, axisRotation::AxisRotation) = @match (face, axisRotation) begin
    (Face(axis, sign), AxisRotation(axis2, rotation)), if axis == axis2
    end => Face(axis, sign)
    (Face(axis, sign), AxisRotation(axis2, rotation)),
    if axis != axis2
    end => begin
        (axis3, sign3) = other(axis2, axis)
        Face(axis3, sign3 * sign * rotation)
    end
end

@enum Coordinate zero = 0 plus = 1 minus = -1

*(coordinate::Coordinate, sign::Sign) = Coordinate(Int(coordinate) * Int(sign))
*(coordinate::Coordinate, rotation::Rotation) = Coordinate(Int(coordinate) * Int(rotation))

struct Position
    positions::Dict{Axis,Coordinate}
end

function *(axisCoordinate::Tuple{Axis,Coordinate}, axisRotation::AxisRotation)
    axis = axisCoordinate[1]
    coordinate = axisCoordinate[2]
    (rotatedAxis, sign) = other(axisRotation.axis, axis)
    newCoordinate = coordinate * sign * axisRotation.rotation
    (rotatedAxis, newCoordinate)
end

function *(position::Position, axisRotation::AxisRotation)
    positions = Dict{Axis,Coordinate}(
        (axis, coordinate) * axisRotation for (axis, coordinate) in position.positions
    )
    print(positions)
end

@enum Color white yellow red orange green blue

struct RawCube
    microCubes::Dict{Tuple{Position,Face},Color}
end

# rawCubeのデフォルト値に生のcubeをセットする

function *(rawCube::RawCube, rotationTuple::Tuple{Face,Rotation})
    # todo
    # FaceとRotationからAxisRotationが作れる
    # Faceから対象Positionをフィルタする
    # PositionとFaceのAxisRotationはある
end

end # module rawCube