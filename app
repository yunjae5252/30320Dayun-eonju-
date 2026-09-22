<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오프타임 - 자발적 디지털 디톡스</title>
    <!-- Chart.js CDN (사용 리포트 그래프용) -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --bg-color: #F2F2F7;
            --card-bg: #FFFFFF;
            --primary: #34C759;
            --primary-dark: #28A745;
            --warning: #FF9500;
            --danger: #FF3B30;
            --text-main: #1C1C1E;
            --text-sub: #8E8E93;
            --border-radius: 18px;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px 10px;
        }

        .phone-container {
            width: 100%;
            max-width: 430px;
            background-color: var(--bg-color);
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            position: relative;
            display: flex;
            flex-direction: column;
            min-height: 840px;
        }

        /* Header */
        header {
            padding: 20px 24px 10px;
            background: var(--bg-color);
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        header h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-main);
            letter-spacing: -0.5px;
        }

        /* Mascot Banner */
        .mascot-banner {
            background: var(--card-bg);
            margin: 12px 20px;
            padding: 16px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.3s ease;
        }

        .mascot-svg {
            width: 70px;
            height: 70px;
            flex-shrink: 0;
        }

        .mascot-speech {
            background: #F0FDF4;
            border: 1.5px solid #BBF7D0;
            border-radius: 14px;
            padding: 10px 14px;
            font-size: 14px;
            font-weight: 600;
            color: #166534;
            position: relative;
            flex-grow: 1;
        }

        .mascot-speech::before {
            content: '';
            position: absolute;
            left: -8px;
            top: 50%;
            transform: translateY(-50%);
            border-width: 6px 8px 6px 0;
            border-style: solid;
            border-color: transparent #BBF7D0 transparent transparent;
        }

        /* Main Content Container */
        .content {
            padding: 0 20px 80px;
            flex-grow: 1;
            overflow-y: auto;
        }

        /* Card Section */
        .card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 16px;
            box-shadow: var(--shadow);
        }

        .card-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-sub);
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Forms & Inputs */
        .form-group {
            margin-bottom: 16px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 8px;
        }

        input[type="time"], input[type="number"], select {
            width: 100%;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid #E5E5EA;
            background: #FAFAFC;
            font-size: 16px;
            outline: none;
            color: var(--text-main);
        }

        /* App Selection Checklist */
        .app-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .app-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 12px;
            background: #F9F9FB;
            border: 1px solid #E5E5EA;
            cursor: pointer;
            user-select: none;
        }

        .app-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: var(--primary);
        }

        .app-item span {
            font-size: 14px;
            font-weight: 500;
        }

        /* Action Button */
        .btn {
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            border: none;
            background: var(--primary);
            color: white;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
            box-shadow: 0 4px 12px rgba(52, 199, 89, 0.3);
        }

        .btn:active {
            transform: scale(0.98);
        }

        .btn-stop {
            background: var(--danger);
            box-shadow: 0 4px 12px rgba(255, 59, 48, 0.3);
        }

        /* Timer Dashboard */
        .timer-display {
            text-align: center;
            padding: 10px 0;
        }

        .timer-value {
            font-size: 48px;
            font-weight: 800;
            color: var(--text-main);
            letter-spacing: -1px;
            margin: 10px 0;
            font-variant-numeric: tabular-nums;
        }

        .timer-subtext {
            font-size: 14px;
            color: var(--text-sub);
        }

        /* Notification Alert Banner */
        .alert-box {
            background: #FFF9E6;
            border: 1px solid #FFE082;
            color: #B78103;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 16px;
            display: none;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.6; }
            100% { opacity: 1; }
        }

        /* Lock Overlay Screen (Step 4) */
        .lock-screen {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(28, 28, 30, 0.95);
            backdrop-filter: blur(20px);
            z-index: 100;
            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            padding: 30px;
            text-align: center;
        }

        .lock-screen h2 {
            font-size: 24px;
            margin-top: 16px;
            margin-bottom: 8px;
        }

        .lock-screen p {
            font-size: 15px;
            color: #A1A1A6;
            margin-bottom: 24px;
        }

        .blocked-apps-tag {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 30px;
        }

        .app-tag {
            background: rgba(255, 255, 255, 0.15);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
        }

        /* Navigation Bar */
        nav {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            border-top: 1px solid #E5E5EA;
            display: flex;
            justify-content: space-around;
            padding: 10px 0 25px;
            z-index: 10;
        }

        .nav-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 11px;
            color: var(--text-sub);
            cursor: pointer;
            border: none;
            background: none;
        }

        .nav-item.active {
            color: var(--primary);
            font-weight: 600;
        }

        .nav-icon {
            font-size: 20px;
            margin-bottom: 2px;
        }

        /* Tab Views */
        .tab-view {
            display: none;
        }

        .tab-view.active {
            display: block;
        }

        /* Segmented Control (Report Tab) */
        .segmented-control {
            display: flex;
            background: #E3E3E8;
            padding: 2px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .segment-btn {
            flex: 1;
            padding: 6px 0;
            border: none;
            background: transparent;
            font-size: 13px;
            font-weight: 500;
            border-radius: 8px;
            cursor: pointer;
            color: var(--text-main);
        }

        .segment-btn.active {
            background: white;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>

<div class="phone-container">
    <!-- Header -->
    <header>
        <h1>오프타임</h1>
        <span style="font-size: 13px; color: var(--text-sub); font-weight: 600;">OFF-TIME</span>
    </header>

    <!-- 도롱뇽 마스코트 (Duolingo 느낌) -->
    <div class="mascot-banner">
        <svg class="mascot-svg" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <!-- Salamander Body -->
            <path d="M20 60 C20 35, 40 25, 60 30 C80 35, 85 55, 75 75 C65 90, 35 90, 20 60 Z" fill="#34C759"/>
            <!-- Salamander Tail -->
            <path d="M70 70 C85 75, 95 65, 90 50 C88 45, 82 50, 80 58 Z" fill="#28A745"/>
            <!-- Head & Cheeks -->
            <circle cx="38" cy="42" r="18" fill="#34C759"/>
            <circle cx="28" cy="48" r="4" fill="#FF9500" opacity="0.6"/>
            <circle cx="48" cy="48" r="4" fill="#FF9500" opacity="0.6"/>
            <!-- Big Cute Eyes (Duolingo Style) -->
            <circle cx="32" cy="38" r="5" fill="white"/>
            <circle cx="33" cy="38" r="2.5" fill="#1C1C1E"/>
            <circle cx="44" cy="38" r="5" fill="white"/>
            <circle cx="43" cy="38" r="2.5" fill="#1C1C1E"/>
            <!-- Happy Smile -->
            <path d="M34 46 Q38 50 42 46" stroke="#1C1C1E" stroke-width="2" stroke-linecap="round" fill="none"/>
            <!-- Little Feet -->
            <ellipse cx="25" cy="72" rx="6" ry="3" fill="#28A745"/>
            <ellipse cx="55" cy="75" rx="6" ry="3" fill="#28A745"/>
        </svg>
        <div class="mascot-speech" id="mascotMessage">
            오늘도 멋지게 집중해볼까요? 목표를 설정해 주세요!
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        
        <!-- ================= TAB 1: 설정 & 타이머 (STEP 1 ~ 4) ================= -->
        <div id="tab-timer" class="tab-view active">
            
            <!-- 알림 경고 박스 (STEP 3) -->
            <div id="alertBox" class="alert-box">
                ⚠️ 시간이 얼마 안 남았습니다! (마감 10분/5분 전)
            </div>

            <!-- STEP 1: 설정 카드 -->
            <div id="setupSection" class="card">
                <div class="card-title">
                    <span>STEP 1. 목표 설정</span>
                    <span style="font-size:12px; color:var(--primary); font-weight:600;">자발적 설정</span>
                </div>
                
                <div class="form-group">
                    <label>하루 목표 사용 시간</label>
                    <div style="display: flex; gap: 10px;">
                        <select id="targetHours">
                            <option value="1">1시간</option>
                            <option value="2">2시간</option>
                            <option value="3" selected>3시간</option>
                            <option value="5">5시간</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>제한 종료 시간 (Curfew)</label>
                    <input type="time" id="curfewTime" value="22:00">
                </div>

                <div class="form-group">
                    <label>시간 완료 시 차단할 앱 선택</label>
                    <div class="app-list">
                        <label class="app-item">
                            <input type="checkbox" value="유튜브" checked>
                            <span>유튜브</span>
                        </label>
                        <label class="app-item">
                            <input type="checkbox" value="인스타그램" checked>
                            <span>인스타그램</span>
                        </label>
                        <label class="app-item">
                            <input type="checkbox" value="틱톡" checked>
                            <span>틱톡</span>
                        </label>
                        <label class="app-item">
                            <input type="checkbox" value="게임">
                            <span>모바일 게임</span>
                        </label>
                    </div>
                </div>

                <button class="btn" style="margin-top: 10px;" onclick="startFocus()">공부 및 디톡스 시작하기</button>
            </div>

            <!-- STEP 2 & 3: 타이머 진행 카드 -->
            <div id="timerSection" class="card" style="display: none;">
                <div class="card-title">
                    <span>STEP 2. 공부 집중 진행 중</span>
                    <span style="font-size:12px; color:var(--primary); font-weight:600;">● 측정 중</span>
                </div>

                <div class="timer-display">
                    <div class="timer-subtext">남은 사용 허용 시간</div>
                    <div class="timer-value" id="timeRemaining">01:00:00</div>
                    <div class="timer-subtext" id="curfewSubtext">제한 시간(22:00)까지 측정됩니다</div>
                </div>

                <button class="btn btn-stop" onclick="stopFocus()">집중 종료하기</button>
            </div>

        </div>

        <!-- ================= TAB 2: 사용 리포트 (STEP 5) ================= -->
        <div id="tab-report" class="tab-view">
            <div class="card">
                <div class="card-title">
                    <span>STEP 5. 핸드폰 사용 리포트</span>
                </div>

                <!-- 기간 선택 (지난 1주일, 1달, 1년) -->
                <div class="segmented-control">
                    <button class="segment-btn active" onclick="updateReport('week', this)">지난 1주일</button>
                    <button class="segment-btn" onclick="updateReport('month', this)">지난 1달</button>
                    <button class="segment-btn" onclick="updateReport('year', this)">지난 1년</button>
                </div>

                <!-- 그래프 영역 -->
                <div style="position: relative; height: 220px; width: 100%;">
                    <canvas id="usageChart"></canvas>
                </div>
            </div>

            <div class="card">
                <div class="card-title">
                    <span>목표 달성 요약</span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0;">
                    <span style="font-size: 15px; color: var(--text-sub);">평균 일일 사용 시간</span>
                    <span style="font-size: 18px; font-weight: 700; color: var(--primary);" id="avgUsageText">2시간 15분</span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-top: 1px solid #F2F2F7;">
                    <span style="font-size: 15px; color: var(--text-sub);">목표 달성률</span>
                    <span style="font-size: 18px; font-weight: 700; color: var(--primary);" id="successRateText">85%</span>
                </div>
            </div>
        </div>

    </div>

    <!-- STEP 4: 앱 차단 & 폰 잠금 화면 (Overlay) -->
    <div id="lockScreen" class="lock-screen">
        <div style="font-size: 60px; margin-bottom: 10px;">🔒</div>
        <h2>오프타임 - 사용 제한 완료</h2>
        <p>설정한 사용 시간 또는 제한 시간에 도달하여<br>선택한 앱이 차단되었습니다.</p>
        
        <div class="blocked-apps-tag" id="blockedAppsContainer">
            <!-- 차단된 앱 태그 표시 -->
        </div>

        <button class="btn" style="background: white; color: var(--text-main); width: 200px;" onclick="unlockPhone()">확인 (잠금 해제)</button>
    </div>

    <!-- 하단 네비게이션 바 -->
    <nav>
        <button class="nav-item active" onclick="switchTab('timer', this)">
            <span class="nav-icon">⏱️</span>
            <span>타이머</span>
        </button>
        <button class="nav-item" onclick="switchTab('report', this)">
            <span class="nav-icon">📊</span>
            <span>사용 리포트</span>
        </button>
    </nav>
</div>

<script>
    // 전역 변수
    let timerInterval = null;
    let totalSeconds = 0;
    let chartInstance = null;

    // 탭 전환
    function switchTab(tabName, element) {
        document.querySelectorAll('.tab-view').forEach(tab => tab.classList.remove('active'));
        document.querySelectorAll('.nav-item').forEach(btn => btn.classList.remove('active'));
        
        document.getElementById(`tab-${tabName}`).classList.add('active');
        element.classList.add('active');

        if(tabName === 'report') {
            initChart();
        }
    }

    // STEP 1 & 2: 공부 및 디톡스 시작
    function startFocus() {
        const hours = parseInt(document.getElementById('targetHours').value);
        const curfew = document.getElementById('curfewTime').value;

        totalSeconds = hours * 3600; // 초 단위 변환

        document.getElementById('setupSection').style.display = 'none';
        document.getElementById('timerSection').style.display = 'block';

        // 마스코트 대사 변경
        setMascotMessage("열심히 공부 중이시군요! 제가 응원하고 있어요 🦎✨");

        updateTimerDisplay();

        // 1초마다 타이머 계산
        timerInterval = setInterval(() => {
            totalSeconds--;
            updateTimerDisplay();

            // STEP 3: 10분, 5분 전 알림 메시지 조건 (테스트용 간이 세팅 포함)
            if (totalSeconds === 600 || totalSeconds === 300) { // 10분(600초) 또는 5분(300초)
                triggerAlert();
            }

            // STEP 4: 시간 종료 시 잠금 실행
            if (totalSeconds <= 0) {
                clearInterval(timerInterval);
                triggerLock();
            }
        }, 1000);
    }

    // 타이머 디스플레이 업데이트
    function updateTimerDisplay() {
        const hrs = Math.floor(totalSeconds / 3600);
        const mins = Math.floor((totalSeconds % 3600) / 60);
        const secs = totalSeconds % 60;

        const formatted = 
            `${String(hrs).padStart(2, '0')}:${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
        
        document.getElementById('timeRemaining').innerText = formatted;
    }

    // STEP 3: 알림 기능 ("시간이 얼마 안 남았습니다!")
    function triggerAlert() {
        const alertBox = document.getElementById('alertBox');
        alertBox.style.display = 'block';
        setMascotMessage("시간이 얼마 안 남았습니다! 조금만 더 힘내세요! 🔥");
        
        setTimeout(() => {
            alertBox.style.display = 'none';
        }, 5000);
    }

    // STEP 4: 특정 앱 차단 및 폰 잠금
    function triggerLock() {
        // 선택된 앱 가져오기
        const selectedApps = [];
        document.querySelectorAll('.app-list input[type="checkbox"]:checked').forEach(cb => {
            selectedApps.push(cb.value);
        });

        const container = document.getElementById('blockedAppsContainer');
        container.innerHTML = '';
        selectedApps.forEach(app => {
            const span = document.createElement('span');
            span.className = 'app-tag';
            span.innerText = `🚫 ${app}`;
            container.appendChild(span);
        });

        document.getElementById('lockScreen').style.display = 'flex';
        setMascotMessage("오늘 목표 시간을 모두 사용하셨습니다! 수고하셨어요 👏");
    }

    // 잠금 해제 및 완료 (STEP 5 동기부여 대사 출력)
    function unlockPhone() {
        document.getElementById('lockScreen').style.display = 'none';
        document.getElementById('timerSection').style.display = 'none';
        document.getElementById('setupSection').style.display = 'block';

        // 동기부여 문구 출력
        const compliments = [
            "아주 잘하셨습니다! 오늘 목표를 완벽히 달성했어요 🎉",
            "오늘도 수고하셨습니다! 내일도 함께해 주세요 💚"
        ];
        const randomMessage = compliments[Math.floor(Math.random() * compliments.length)];
        setMascotMessage(randomMessage);
    }

    function stopFocus() {
        clearInterval(timerInterval);
        document.getElementById('timerSection').style.display = 'none';
        document.getElementById('setupSection').style.display = 'block';
        setMascotMessage("언제든 준비되었을 때 다시 시작해 주세요!");
    }

    // 마스코트 대사 변경 함수
    function setMascotMessage(msg) {
        document.getElementById('mascotMessage').innerText = msg;
    }

    // STEP 5: Chart.js를 이용한 사용 리포트 그래프 (지난 1주일, 1달, 1년)
    function initChart() {
        if (chartInstance) return;

        const ctx = document.getElementById('usageChart').getContext('2d');
        chartInstance = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['월', '화', '수', '목', '금', '토', '일'],
                datasets: [{
                    label: '사용 시간 (시간)',
                    data: [2.5, 1.8, 3.0, 2.0, 1.5, 4.0, 2.2],
                    backgroundColor: '#34C759',
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: '#E5E5EA' }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });
    }

    // 리포트 기간 데이터 변경
    function updateReport(type, btn) {
        document.querySelectorAll('.segment-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        if (!chartInstance) return;

        if (type === 'week') {
            chartInstance.data.labels = ['월', '화', '수', '목', '금', '토', '일'];
            chartInstance.data.datasets[0].data = [2.5, 1.8, 3.0, 2.0, 1.5, 4.0, 2.2];
            document.getElementById('avgUsageText').innerText = '2시간 15분';
            document.getElementById('successRateText').innerText = '85%';
        } else if (type === 'month') {
            chartInstance.data.labels = ['1주차', '2주차', '3주차', '4주차'];
            chartInstance.data.datasets[0].data = [18, 14, 21, 15];
            document.getElementById('avgUsageText').innerText = '2시간 30분';
            document.getElementById('successRateText').innerText = '78%';
        } else if (type === 'year') {
            chartInstance.data.labels = ['1월', '3월', '5월', '7월', '9월', '11월'];
            chartInstance.data.datasets[0].data = [75, 68, 80, 55, 60, 50];
            document.getElementById('avgUsageText').innerText = '2시간 05분';
            document.getElementById('successRateText').innerText = '90%';
        }
        chartInstance.update();
    }
</script>

</body>
</html>
