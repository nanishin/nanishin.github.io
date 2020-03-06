---
#layout: posts
comments: true
title:  "DIY 3D 프린터에 오토베드레벨링 적용"
toc: true
toc_sticky: true
header:
  teaser: /assets/images/nanishin.png
date:   2019-03-03 15:30:00 +0900
categories:
  - maker
tags:
  - 3D 프린터
  - 오토베드레벨링
---
ANET A8을 주문할 당시 처음부터 옵션으로 선택했던 오토베드레벨링 센서 세트...

그러나 OctoPrint와의 원활한 연동을 위해 Marlin 1.1.9 펌웨어로 바꾸면서 이리저리 수동 설정에 집중하느라

정작 4개월 가량을 그냥 버려두고 있었다는... -ㅠ- 그러다 누구나 이야기하는 수동 베드레벨링 지옥을 겪다 보니

결국 오랜만에 Marlin 펌웨어 설정과 일부 패치 적용 후 오토베드레벨링 활성화 완료!!!

처음에 저 근접센서 감도와 노즐과 베드 사이 거리를 미세하기 맞추기 위해선 여전히 휴리스틱 튜닝(일명 노가다 조정)이

필요했지만 일단 맞춰두고 나니 쾌적한 3D 프린팅 세상이 열림~ :D

![SN04-N](/assets/images/20190303_105919.png)

설정한 옵션 위주로 정리

# Marlin 1.1.9의 Configuration.h 파일
```cpp
/**
 * Choose one of the options below to enable G29 Bed Leveling. The parameters
 * and behavior of G29 will change depending on your selection.
 *
 *  If using a Probe for Z Homing, enable Z_SAFE_HOMING also!
 *
 * - AUTO_BED_LEVELING_3POINT
 *   Probe 3 arbitrary points on the bed (that aren't collinear)
 *   You specify the XY coordinates of all 3 points.
 *   The result is a single tilted plane. Best for a flat bed.
 *
 * - AUTO_BED_LEVELING_LINEAR
 *   Probe several points in a grid.
 *   You specify the rectangle and the density of sample points.
 *   The result is a single tilted plane. Best for a flat bed.
 *
 * - AUTO_BED_LEVELING_BILINEAR
 *   Probe several points in a grid.
 *   You specify the rectangle and the density of sample points.
 *   The result is a mesh, best for large or uneven beds.
 *
 * - AUTO_BED_LEVELING_UBL (Unified Bed Leveling)
 *   A comprehensive bed leveling system combining the features and benefits
 *   of other systems. UBL also includes integrated Mesh Generation, Mesh
 *   Validation and Mesh Editing systems.
 *
 * - MESH_BED_LEVELING
 *   Probe a grid manually
 *   The result is a mesh, suitable for large or uneven beds. (See BILINEAR.)
 *   For machines without a probe, Mesh Bed Leveling provides a method to perform
 *   leveling in steps so you can manually adjust the Z height at each grid-point.
 *   With an LCD controller the process is guided step-by-step.
 */
//#define AUTO_BED_LEVELING_3POINT
//#define AUTO_BED_LEVELING_LINEAR
#define AUTO_BED_LEVELING_BILINEAR
//#define AUTO_BED_LEVELING_UBL
//#define MESH_BED_LEVELING

/**
 *   Z Probe to nozzle (X,Y) offset, relative to (0, 0).
 *   X and Y offsets must be integers.
 *
 *   In the following example the X and Y offsets are both positive:
 *   #define X_PROBE_OFFSET_FROM_EXTRUDER 10
 *   #define Y_PROBE_OFFSET_FROM_EXTRUDER 10
 *
 *      +-- BACK ---+
 *      |           |
 *    L |    (+) P  | R <-- probe (20,20)
 *    E |           | I
 *    F | (-) N (+) | G <-- nozzle (10,10)
 *    T |           | H
 *      |    (-)    | T
 *      |           |
 *      O-- FRONT --+
 *    (0,0)
 */
#define X_PROBE_OFFSET_FROM_EXTRUDER 15   // X offset: -left  +right  [of the nozzle]
#define Y_PROBE_OFFSET_FROM_EXTRUDER 55   // Y offset: -front +behind [the nozzle]
#define Z_PROBE_OFFSET_FROM_EXTRUDER 0   // Z offset: -below +above  [the nozzle]

// The size of the print bed
#define X_BED_SIZE 220
#define Y_BED_SIZE 220

// Set the boundaries for probing (where the probe can reach).
//#define LEFT_PROBE_BED_POSITION MIN_PROBE_EDGE
//#define RIGHT_PROBE_BED_POSITION (X_BED_SIZE - MIN_PROBE_EDGE)
//#define FRONT_PROBE_BED_POSITION MIN_PROBE_EDGE
//#define BACK_PROBE_BED_POSITION (Y_BED_SIZE - MIN_PROBE_EDGE)
#if X_PROBE_OFFSET_FROM_EXTRUDER < 0
  #define LEFT_PROBE_BED_POSITION (MIN_PROBE_EDGE)
  #define RIGHT_PROBE_BED_POSITION (X_BED_SIZE - 1 - MIN_PROBE_EDGE + X_PROBE_OFFSET_FROM_EXTRUDER)
#else
  #define LEFT_PROBE_BED_POSITION (X_PROBE_OFFSET_FROM_EXTRUDER + MIN_PROBE_EDGE)
  #define RIGHT_PROBE_BED_POSITION (X_BED_SIZE - 1 - MIN_PROBE_EDGE)
#endif
#if Y_PROBE_OFFSET_FROM_EXTRUDER < 0
  #define FRONT_PROBE_BED_POSITION (MIN_PROBE_EDGE)
  #define BACK_PROBE_BED_POSITION (Y_BED_SIZE - 1 - MIN_PROBE_EDGE + Y_PROBE_OFFSET_FROM_EXTRUDER)
#else
  #define FRONT_PROBE_BED_POSITION (Y_PROBE_OFFSET_FROM_EXTRUDER + MIN_PROBE_EDGE)
  #define BACK_PROBE_BED_POSITION (Y_BED_SIZE - 1 - MIN_PROBE_EDGE)
#endif

// Use "Z Safe Homing" to avoid homing with a Z probe outside the bed area.
//
// With this feature enabled:
//
// - Allow Z homing only after X and Y homing AND stepper drivers still enabled.
// - If stepper drivers time out, it will need X and Y homing again before Z homing.
// - Move the Z probe (or nozzle) to a defined XY point before Z Homing when homing all axes (G28).
// - Prevent Z homing when the Z probe is outside bed area.
//
#define Z_SAFE_HOMING

/**
 * A Fix-Mounted Probe either doesn't deploy or needs manual deployment.
 *   (e.g., an inductive probe or a nozzle-based probe-switch.)
 */
#define FIX_MOUNTED_PROBE

/**
 * Z_MIN_PROBE_USES_Z_MIN_ENDSTOP_PIN
 *
 * Enable this option for a probe connected to the Z Min endstop pin.
 */
#define Z_MIN_PROBE_USES_Z_MIN_ENDSTOP_PIN
```

# G29 G-Code 명령어 적용
항상 프린팅 시작하기 전에 오토베드레벨링을 수행하기 위해 G28 X/Y/X 축 초기화 명령 후 적용
![G29 G-Code](/assets/images/g29_gcode_auto_level.png)

