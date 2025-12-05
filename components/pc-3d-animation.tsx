"use client"

import { Suspense, useState, useEffect } from "react"
import { Canvas } from "@react-three/fiber"
import { OrbitControls, PerspectiveCamera } from "@react-three/drei"

// PC Component 3D Models (simplified representations)
function Motherboard({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      <mesh>
        <boxGeometry args={[3, 0.1, 2.5]} />
        <meshStandardMaterial color="#1a1a1a" metalness={0.3} roughness={0.7} />
      </mesh>
      {/* CPU Socket */}
      <mesh position={[0, 0.1, 0]}>
        <boxGeometry args={[0.5, 0.1, 0.5]} />
        <meshStandardMaterial color="#2a2a2a" />
      </mesh>
      {/* RAM Slots */}
      <mesh position={[0.8, 0.1, -0.5]}>
        <boxGeometry args={[0.3, 0.1, 1]} />
        <meshStandardMaterial color="#3a3a3a" />
      </mesh>
      <mesh position={[-0.8, 0.1, -0.5]}>
        <boxGeometry args={[0.3, 0.1, 1]} />
        <meshStandardMaterial color="#3a3a3a" />
      </mesh>
    </group>
  )
}

function CPU({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      <mesh>
        <boxGeometry args={[0.4, 0.05, 0.4]} />
        <meshStandardMaterial color="#0066cc" metalness={0.8} roughness={0.2} />
      </mesh>
    </group>
  )
}

function RAM({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      <mesh>
        <boxGeometry args={[0.25, 0.15, 0.9]} />
        <meshStandardMaterial color="#0066ff" metalness={0.6} roughness={0.4} />
      </mesh>
    </group>
  )
}

function GPU({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      <mesh>
        <boxGeometry args={[1.2, 0.3, 0.4]} />
        <meshStandardMaterial color="#1a1a1a" metalness={0.5} roughness={0.5} />
      </mesh>
      {/* Fans */}
      <mesh position={[0.3, 0.35, 0]}>
        <cylinderGeometry args={[0.15, 0.15, 0.05, 16]} />
        <meshStandardMaterial color="#333" />
      </mesh>
      <mesh position={[-0.3, 0.35, 0]}>
        <cylinderGeometry args={[0.15, 0.15, 0.05, 16]} />
        <meshStandardMaterial color="#333" />
      </mesh>
    </group>
  )
}

function PSU({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      <mesh>
        <boxGeometry args={[0.8, 1.2, 0.6]} />
        <meshStandardMaterial color="#0a0a0a" metalness={0.4} roughness={0.6} />
      </mesh>
    </group>
  )
}

function Case({ position, rotation }: { position: [number, number, number], rotation?: [number, number, number] }) {
  return (
    <group position={position} rotation={rotation || [0, 0, 0]}>
      {/* Case frame */}
      <mesh>
        <boxGeometry args={[4, 3.5, 2.8]} />
        <meshStandardMaterial color="#2a2a2a" metalness={0.2} roughness={0.8} transparent opacity={0.3} />
      </mesh>
      {/* Case edges */}
      <mesh position={[0, 0, 1.4]}>
        <boxGeometry args={[4, 3.5, 0.05]} />
        <meshStandardMaterial color="#1a1a1a" />
      </mesh>
    </group>
  )
}

function PCBuildScene({ currentStep }: { currentStep: number }) {
  const [hovered, setHovered] = useState(false)
  
  // Animate components based on current step
  const stepComponents: Record<number, JSX.Element[]> = {
    1: [
      <Case key="case" position={[0, 0, 0]} />
    ],
    2: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <CPU key="cpu" position={[0, 0.65, 0]} />
    ],
    3: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <CPU key="cpu" position={[0, 0.65, 0]} />
    ],
    4: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <CPU key="cpu" position={[0, 0.65, 0]} />,
      <RAM key="ram1" position={[0.8, 0.65, -0.5]} />,
      <RAM key="ram2" position={[-0.8, 0.65, -0.5]} />
    ],
    5: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />
    ],
    6: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />
    ],
    7: [
      <Case key="case" position={[0, 0, 0]} />,
      <PSU key="psu" position={[-1.5, -0.5, 0]} />
    ],
    8: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <GPU key="gpu" position={[0, 0.3, 0.6]} />
    ],
    9: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <CPU key="cpu" position={[0, 0.65, 0]} />,
      <RAM key="ram1" position={[0.8, 0.65, -0.5]} />,
      <RAM key="ram2" position={[-0.8, 0.65, -0.5]} />,
      <GPU key="gpu" position={[0, 0.3, 0.6]} />,
      <PSU key="psu" position={[-1.5, -0.5, 0]} />
    ],
    10: [
      <Case key="case" position={[0, 0, 0]} />,
      <Motherboard key="mb" position={[0, 0.5, 0]} />,
      <CPU key="cpu" position={[0, 0.65, 0]} />,
      <RAM key="ram1" position={[0.8, 0.65, -0.5]} />,
      <RAM key="ram2" position={[-0.8, 0.65, -0.5]} />,
      <GPU key="gpu" position={[0, 0.3, 0.6]} />,
      <PSU key="psu" position={[-1.5, -0.5, 0]} />
    ]
  }

  const components = stepComponents[currentStep] || stepComponents[1]

  return (
    <>
      <ambientLight intensity={0.5} />
      <directionalLight position={[5, 5, 5]} intensity={1} />
      <pointLight position={[-5, -5, -5]} intensity={0.5} />
      
      <group
        onPointerOver={() => setHovered(true)}
        onPointerOut={() => setHovered(false)}
      >
        {components}
      </group>
      
      <OrbitControls
        enablePan={true}
        enableZoom={true}
        enableRotate={true}
        minDistance={3}
        maxDistance={10}
        autoRotate={!hovered}
        autoRotateSpeed={0.5}
      />
      
      <PerspectiveCamera makeDefault position={[5, 5, 5]} fov={50} />
    </>
  )
}

interface PC3DAnimationProps {
  currentStep?: number
  className?: string
}

export function PC3DAnimation({ currentStep = 1, className = "" }: PC3DAnimationProps) {
  const [isClient, setIsClient] = useState(false)

  useEffect(() => {
    setIsClient(true)
  }, [])

  if (!isClient || typeof window === 'undefined') {
    return (
      <div className={`w-full aspect-video rounded-lg border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center ${className}`}>
        <p className="text-slate-400">Loading 3D animation...</p>
      </div>
    )
  }

  return (
    <div className={`w-full aspect-video rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 to-slate-800 ${className}`}>
      <Suspense fallback={
        <div className="w-full h-full flex items-center justify-center">
          <p className="text-slate-400">Loading 3D animation...</p>
        </div>
      }>
        <Canvas
          gl={{ antialias: true, alpha: false }}
          dpr={[1, 2]}
          frameloop="demand"
        >
          <PCBuildScene currentStep={currentStep} />
        </Canvas>
      </Suspense>
    </div>
  )
}

